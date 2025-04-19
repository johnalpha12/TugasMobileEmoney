import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password.dart';

class SecurityCode extends StatefulWidget {
  const SecurityCode({Key? key}) : super(key: key);

  @override
  State<SecurityCode> createState() => _SecurityCodeState();
}

class _SecurityCodeState extends State<SecurityCode> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();

    // Set up listeners for each text field to handle backspace
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].addListener(() {
        // When a field gets focus, put cursor at the end
        if (_focusNodes[i].hasFocus) {
          _controllers[i].selection = TextSelection.fromPosition(
            TextPosition(offset: _controllers[i].text.length),
          );
        }
      });

      // Add listeners to controllers to detect text changes including deletion
      _controllers[i].addListener(() {
        if (i > 0 && _controllers[i].text.isEmpty && _focusNodes[i].hasFocus) {
          // This likely means backspace was pressed on an empty field
          // This listener runs after the onChanged event below
          // We'll handle backspace in the keyboard input formatter instead
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onSubmit() {
    // Check if all fields have values
    bool allFieldsFilled = _controllers.every(
      (controller) => controller.text.isNotEmpty,
    );

    if (allFieldsFilled) {
      // Navigate to password.dart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Password()),
      );
    } else {
      // Show a simple error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all security code fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E24AA),
        title: const Text('Security Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Masukkan Security Code Anda saat ini',
                  style: TextStyle(
                    color: Color(0xFF8E24AA),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Security Code digunakan untuk masuk ke akun Anda dan bertransaksi',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 40),
              // Security code input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      obscureText: true,
                      decoration: const InputDecoration(
                        counterText: '',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF8E24AA),
                            width: 2,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // Custom input formatter to handle backspace functionality
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          // If text is removed (backspace pressed)
                          if (oldValue.text.isNotEmpty &&
                              newValue.text.isEmpty) {
                            // If we're not at the first field, move to previous field
                            if (index > 0) {
                              // Schedule for next frame to avoid build conflicts
                              Future.microtask(() {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[index - 1]);
                              });
                            }
                          }
                          return newValue;
                        }),
                      ],
                      onChanged: (value) {
                        // Handle digit input (move to next field)
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_focusNodes[index + 1]);
                        }
                        // Handle backspace on empty field - move focus back
                        else if (value.isEmpty && index > 0) {
                          // We'll let the input formatter handle this
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Submit button
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E24AA),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
