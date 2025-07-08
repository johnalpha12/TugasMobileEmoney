import 'package:flutter/material.dart';

class ForgotPinPage extends StatefulWidget {
  @override
  State<ForgotPinPage> createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();

  void _handleReset() {
    final phone = phoneController.text.trim();
    final pin = newPinController.text.trim();

    if (phone.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi semua kolom.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    phoneController.dispose();
    newPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text('Reset PIN', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Masukkan nomor telepon dan PIN baru Anda.',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 12, // Batas maksimal 12 digit
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                counterText: '', // Menghilangkan teks penghitung karakter
                hintText: 'Nomor Telepon',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.deepPurple.shade400,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: newPinController,
              obscureText: true,
              maxLength: 5,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                counterText: '',
                hintText: 'PIN Baru',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.deepPurple.shade400,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text('Reset PIN'),
            ),
          ],
        ),
      ),
    )
    );
  }
}
