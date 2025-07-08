import 'package:flutter/material.dart';

class QrisPage extends StatelessWidget {
  const QrisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildPurpleHeader(context),
          _buildQrCard(),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildPurpleHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(color: Colors.deepPurple),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Rp. 15.000.000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.lock, color: Colors.white, size: 20),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _HeaderButton(icon: Icons.qr_code_scanner, text: "Pindai"),
                _HeaderButton(icon: Icons.add, text: "Isi Saldo"),
                _HeaderButton(icon: Icons.attach_money, text: "Kirim"),
                _HeaderButton(icon: Icons.request_page, text: "Minta"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCard() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: 8,
            left: 8,
            child: Icon(Icons.image, color: Colors.white),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.edit, color: Colors.white),
          ),
          Center(
            child: Text(
              'QRIS',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BottomAction(icon: Icons.qr_code, label: "Pindai"),
              _BottomAction(icon: Icons.close, label: "Tutup"),
              _BottomAction(icon: Icons.credit_card, label: "Tambah Kartu"),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HeaderButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class _BottomAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: Colors.black),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
