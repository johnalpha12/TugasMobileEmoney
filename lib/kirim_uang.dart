import 'package:flutter/material.dart';
import 'package:tugas/home.dart';

class KirimUangApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KirimUangPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KirimUangPage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'Mike Tyson', 'img': 'asset/elogo1.png'},
    {'name': 'Billie Eilish', 'img': 'asset/elogo1.png'},
    {'name': 'Jackson Wang', 'img': 'asset/elogo2.png'},
    {'name': 'Taylor Swift', 'img': 'asset/elogo4.png'},
    {'name': 'Olivia Rodrigo', 'img': 'asset/elogo1.png'},
    {'name': 'Keshi', 'img': 'asset/elogo4.png'},
    {'name': 'Shawn Mendes', 'img': 'asset/elogo3.png'},
    {'name': 'Niki Zefanya', 'img': 'asset/elogo1.png'},
  ];

  final List<Map<String, String>> actions = [
    {'label': 'send to grup', 'img': 'asset/ilogo1.png'},
    {'label': 'send to friend', 'img': 'asset/ilogo2.png'},
    {'label': 'send to bank', 'img': 'asset/ilogo3.png'},
    {'label': 'send to e-wallet', 'img': 'asset/ilogo4.png'},
    {'label': 'send cash code', 'img': 'asset/ilogo5.png'},
    {'label': 'cash pull', 'img': 'asset/ilogo6.png'},
    {'label': 'send to email', 'img': 'asset/ilogo7.png'},
    {'label': 'scan code QR', 'img': 'asset/ilogo8.png'},
    {'label': 'send to chat', 'img': 'asset/ilogo5.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              "Kirim Uang",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "cari no hp/rekening bank",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildSection("contacts", contacts, isContact: true),
              SizedBox(height: 20),
              _buildSection("actions", actions),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String sectionTitle,
    List<Map<String, String>> items, {
    bool isContact = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children:
            items.map((item) {
              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(item['img']!, width: 50, height: 50),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item[isContact ? 'name' : 'label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
