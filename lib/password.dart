import 'package:flutter/material.dart';
import 'SecurtyCode.dart';
import 'forgotpin.dart';

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordComponen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PasswordComponen extends StatefulWidget {
  @override
  State<PasswordComponen> createState() => _PasswordComponenState();
}

class _PasswordComponenState extends State<PasswordComponen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan PIN Anda',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  _pinControllers
                      .map(
                        (controller) => Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: controller,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPinPage()),
                );
              },
              child: Text('Forgot PIN', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            _buildKeypad(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
                if (_isPinComplete()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecurtyCode()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Masukkan sandi Anda terlebih dahulu'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
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
      padding: EdgeInsets.symmetric(horizontal: 60),
      children:
          buttons.map((text) {
            if (text == '') {
              return SizedBox.shrink();
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
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
        minimumSize: Size(60, 60),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 24)),
    );
  }
}
