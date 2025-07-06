import 'package:flutter/material.dart';

class PromoBannerPage extends StatelessWidget {
  const PromoBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Promo Banner',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBanner(
            image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
            title: 'Cashback 50% untuk Top Up!',
            desc: 'Nikmati cashback hingga 50% setiap kali top up saldo CashEase.',
          ),
          const SizedBox(height: 20),
          _buildBanner(
            image: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=80',
            title: 'Promo Belanja Online',
            desc: 'Diskon spesial untuk pembayaran di merchant pilihan.',
          ),
          const SizedBox(height: 20),
          _buildBanner(
            image: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
            title: 'Gratis Biaya Transfer',
            desc: 'Transfer ke bank mana saja tanpa biaya admin!',
          ),
        ],
      ),
    );
  }

  Widget _buildBanner({required String image, required String title, required String desc}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(image, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}