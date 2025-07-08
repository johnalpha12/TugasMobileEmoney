import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CairPage extends StatefulWidget {
  final String bankName;

  const CairPage({super.key, required this.bankName});

  @override
  State<CairPage> createState() => _CairPageState();
}

class _CairPageState extends State<CairPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final NumberFormat _currencyFormat = NumberFormat.decimalPattern('id');

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_formatCurrency);
  }

  void _formatCurrency() {
    final value = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (value.isNotEmpty) {
      final formatted = _currencyFormat.format(int.parse(value));
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _submitWithdrawal() {
    final amount = _amountController.text.trim();
    final pin = _pinController.text.trim();

    if (amount.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Harap isi nominal dan PIN terlebih dahulu'),
        ),
      );
      return;
    }

    Navigator.pop(context); // Langsung kembali ke halaman withdraw.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Form Penarikan', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode: ${widget.bankName}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Nominal Penarikan',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Contoh: 100000',
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
            Text(
              'Masukkan PIN',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                counterText: '',
                hintText: '••••••',
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: _submitWithdrawal,
                child: Text('Tarik Dana'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
