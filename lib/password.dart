import 'package:flutter/material.dart';
import 'home.dart'; // Import file home.dart

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordComponent(),
      debugShowCheckedModeBanner: false,
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
    6,
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

  // Fungsi untuk memeriksa apakah semua field PIN sudah terisi
  bool isPinComplete() {
    return _pinControllers.every((controller) => controller.text.isNotEmpty);
  }

  // Fungsi untuk navigasi ke halaman home
  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            Text(
              'Masukkan PIN Anda',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  _pinControllers
                      .map(
                        (controller) => Container(
                          width: 45,
                          height: 45,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: controller,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            GestureDetector(
              onTap: () {
                // Aksi lupa PIN
              },
              child: Text(
                'Forgot PIN',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            _buildKeypad(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman home ketika tombol continue ditekan
                    navigateToHome(context);
                  },
                  child: Text('Continue', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    final buttons = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 20, // Jarak antar tombol secara vertikal
        crossAxisSpacing: 20, // Jarak antar tombol secara horizontal
        physics: NeverScrollableScrollPhysics(),
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
      ),
    );
  }

  Widget _keypadButton(String text, VoidCallback onPressed) {
    // Menghilangkan border dan mengubah ke tombol tanpa bulatan
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
