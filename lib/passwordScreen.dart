import 'package:flutter/material.dart';
import 'forgotpin.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: PasswordComponent(),
    );
  }
}

class PasswordComponent extends StatefulWidget {
  const PasswordComponent({super.key});

  @override
  State<PasswordComponent> createState() => _PasswordComponentState();
}

class _PasswordComponentState extends State<PasswordComponent> {
  final List<TextEditingController> _pinControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );

  void _handleKeypadInput(String value) {
    for (final controller in _pinControllers) {
      if (controller.text.isEmpty) {
        setState(() {
          controller.text = value;
        });
        break;
      }
    }
  }

  void _handleDelete() {
    for (int i = _pinControllers.length - 1; i >= 0; i--) {
      if (_pinControllers[i].text.isNotEmpty) {
        setState(() {
          _pinControllers[i].clear();
        });
        break;
      }
    }
  }

  bool _isPinComplete() {
    return _pinControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  void dispose() {
    for (final controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Masukkan PIN Anda',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                _pinControllers.map((controller) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      controller: controller,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ForgotPinPage()),
              );
            },
            child: const Text(
              'Forgot PIN',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          _buildKeypad(),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: const Size(200, 50),
            ),
            onPressed: () {
              if (_isPinComplete()) {
                Navigator.pop(context, true); // <- kirim verifikasi berhasil
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Masukkan sandi Anda terlebih dahulu'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    final buttons = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      padding: const EdgeInsets.symmetric(horizontal: 60),
      children:
          buttons.map((text) {
            if (text == '') {
              return const SizedBox.shrink();
            } else if (text == '⌫') {
              return _keypadButton(text, _handleDelete);
            } else {
              return _keypadButton(text, () => _handleKeypadInput(text));
            }
          }).toList(),
    );
  }

  Widget _keypadButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        minimumSize: const Size(60, 60),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }
}
