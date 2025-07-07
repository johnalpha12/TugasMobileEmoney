import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'passwordScreen.dart';

class TopUpPage extends StatefulWidget {
  final int currentBalance;

  const TopUpPage({super.key, required this.currentBalance});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final List<Map<String, dynamic>> _banks = [
    {'name': 'BCA', 'logo': 'asset/elogo1.png'},
    {'name': 'Mandiri', 'logo': 'asset/elogo2.png'},
    {'name': 'BNI', 'logo': 'asset/elogo5.png'},
    {'name': 'Permata Bank', 'logo': 'asset/elogo3.png'},
  ];

  int? _selectedBankIndex;
  final TextEditingController _amountController = TextEditingController();
  final formatter = NumberFormat.decimalPattern('id_ID');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Isi Saldo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dari Bank', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_banks.length, (index) {
                final bank = _banks[index];
                final isSelected = index == _selectedBankIndex;
                return ChoiceChip(
                  label: Text(bank['name']),
                  avatar: Image.asset(bank['logo'], width: 24, height: 24),
                  selected: isSelected,
                  selectedColor: Colors.deepPurple.shade100,
                  onSelected: (_) => setState(() => _selectedBankIndex = index),
                );
              }),
            ),
            const SizedBox(height: 30),
            const Text('Jumlah Top Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ThousandsFormatter(formatter),
              ],
              decoration: const InputDecoration(
                hintText: 'Masukkan nominal (cth: 100000)',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () async {
                  final cleaned =
                      _amountController.text.replaceAll('.', '').replaceAll(',', '');
                  final int? amount = int.tryParse(cleaned);

                  if (_selectedBankIndex == null) {
                    _showSnackBar('Silakan pilih bank');
                  } else if (amount == null || amount <= 0) {
                    _showSnackBar('Masukkan jumlah yang valid');
                  } else {
                    final pinVerified = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(builder: (_) => const PasswordScreen()),
                    );

                    if (pinVerified == true) {
                      Navigator.pop(context, amount); // Send amount to Home
                    } else {
                      _showSnackBar('Verifikasi PIN dibatalkan');
                    }
                  }
                },
                child: const Text('Isi Sekarang', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom formatter to format number with thousands separator while typing
class ThousandsFormatter extends TextInputFormatter {
  final NumberFormat formatter;
  ThousandsFormatter(this.formatter);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleanText = newValue.text.replaceAll(RegExp(r'[.,]'), '');
    if (cleanText.isEmpty) return newValue;

    final int? number = int.tryParse(cleanText);
    if (number == null) return oldValue;

    final newFormatted = formatter.format(number);
    return TextEditingValue(
      text: newFormatted,
      selection: TextSelection.collapsed(offset: newFormatted.length),
    );
  }
}
