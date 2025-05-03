import 'package:flutter/material.dart';
import 'home.dart';

class SecurtyCode extends StatefulWidget {
  const SecurtyCode({super.key});

  @override
  State<SecurtyCode> createState() => _SecurtyCodeState();
}

class _SecurtyCodeState extends State<SecurtyCode> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          title: const Text(
            "Security Code",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Masukkan Security Code Anda Saat Ini",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "Security Code Digunakan untuk masuk Ke Akun Anda dan Bertransaksi",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: "Masukkan Kode Verifikasi",
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
