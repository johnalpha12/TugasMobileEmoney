import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashEase',
      debugShowCheckedModeBanner: false,
      home: LoginComponen(),
    );
  }
}

class LoginComponen extends StatefulWidget {
  @override
  _LoginComponenState createState() => _LoginComponenState();
}

class _LoginComponenState extends State<LoginComponen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    setState(() {
      _isValid = _phoneController.text.trim().length == 12;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'asset/logo2.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'CashEase',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Dompet Digital untuk Anda!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 80),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Masuk/daftar dengan nomor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'dan mulai nikmati semua yang terbaik',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('+62', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          Icon(
                            _phoneController.text.isEmpty || !_isValid
                                ? Icons.cancel
                                : Icons.check_circle,
                            color:
                                _phoneController.text.isEmpty || !_isValid
                                    ? Colors.grey
                                    : Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed:
                            _isValid
                                ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Password(),
                                    ),
                                  );
                                }
                                : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Nomor HP harus 12 digit angka',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                        child: Text(
                          'Lanjutkan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
