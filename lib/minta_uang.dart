import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

class BagiUangApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BagiUangPage(), debugShowCheckedModeBanner: false);
  }
}

class BagiUangPage extends StatelessWidget {
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
              "Minta Uang",
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
              _buildSection("Kontak", contacts, isContact: true),
              SizedBox(height: 20),
              _metodelainnya(),
              SizedBox(height: 20),
              _permintaanaktif(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Map<String, String>> items, {
    bool isContact = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children:
                items.map((item) {
                  return SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            item['img']!,
                            width: 50,
                            height: 50,
                          ),
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
        ],
      ),
    );
  }

  Widget _metodelainnya() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Metode Lainnya",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(FontAwesomeIcons.random),
                  label: Text("Link"),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(FontAwesomeIcons.qrcode),
                  label: Text("Kode QR"),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _permintaanaktif() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Permintaan Aktif",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  "RIWAYAT",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  foregroundColor: Color(0xFF3A7BD5),
                  side: BorderSide(color: Color(0xFF3A7BD5)),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Column(
            children: [
              Text(
                "Masih Kosong nih..",
                style: TextStyle(fontSize: 12, color: Color(0xFFB7B7B7)),
              ),
              Text(
                "Coba buat baru daftar permintaanmu",
                style: TextStyle(fontSize: 12, color: Color(0xFFB7B7B7)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
