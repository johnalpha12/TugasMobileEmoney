import 'package:flutter/material.dart';

class CreditCardPaymentPage extends StatefulWidget {
  @override
  _CreditCardPaymentPageState createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedBank = 'BCA';

  final List<Map<String, dynamic>> _banks = [
    {'name': 'BCA', 'logo': 'asset/elogo1.png'},
    {'name': 'Mandiri', 'logo': 'asset/elogo2.png'},
    {'name': 'BNI', 'logo': 'asset/elogo5.png'},
    {'name': 'Permata Bank', 'logo': 'asset/elogo3.png'},
  ];

  List<Map<String, String>> _history = [];

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _history.insert(0, {
          'bank': _selectedBank ?? '',
          'card': _cardNumberController.text,
          'amount': _amountController.text,
          'date': DateTime.now().toString().substring(0, 16),
        });
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Pembayaran berhasil!')));
      _cardNumberController.clear();
      _amountController.clear();
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget _buildBankDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBank,
      decoration: InputDecoration(
        labelText: 'Nama Bank',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      items:
          _banks.map((bank) {
            return DropdownMenuItem<String>(
              value: bank['name'],
              child: Row(
                children: [
                  Image.asset(
                    bank['logo']!,
                    width: 28,
                    height: 28,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.account_balance),
                  ),
                  SizedBox(width: 8),
                  Text(
                    bank['name']!,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedBank = value;
        });
      },
      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      style: TextStyle(color: Colors.black, fontSize: 16),
      dropdownColor: Colors.white,
    );
  }

  Widget _buildInfoBox() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF6F1FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0D7F3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.deepPurple, size: 18),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Informasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "• Minimum pembayaran adalah Rp50.000\n"
                  "• Lakukan pembayaran sebelum tanggal jatuh tempo karena terdapat proses verifikasi selama 1 hari kerja.\n"
                  "• Cek kembali jenis kartu kredit & bank penyedia pilihanmu. Kartu kredit Visa selalu diawali angka 4.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    if (_history.isEmpty) {
      return SizedBox(); // Tidak menampilkan apa pun
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 32, left: 8, bottom: 8),
          child: Text(
            "Riwayat Pembayaran",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ..._history.map(
          (item) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.credit_card, color: Colors.deepPurple),
              title: Text('${item['bank']} - ${item['card']}'),
              subtitle: Text('Rp ${item['amount']} • ${item['date']}'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1FB),
      appBar: AppBar(
        backgroundColor: Color(0xFF7C3AED),
        elevation: 0,
        title: const Text(
          'Credit Card',
          style: TextStyle(color: Colors.white), // Warna putih untuk judul
        ),
        leading: BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
              color: Color(0xFF7C3AED),
              padding: EdgeInsets.only(bottom: 32),
              child: SizedBox(height: 0),
            ),
            Transform.translate(
              offset: Offset(0, -32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFE0D7F3)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBankDropdown(),
                        const SizedBox(height: 18),
                        Text(
                          'Nomor Kartu Kredit',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Contoh 1234 5678 9012 3456',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nomor kartu kredit';
                            }
                            if (value.length < 16) {
                              return 'Nomor kartu tidak valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nominal Pembayaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: 'Rp ',
                            prefixStyle: TextStyle(
                              color: Color(0xFF7C3AED),
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: '0',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan jumlah pembayaran';
                            }
                            final amount = int.tryParse(
                              value.replaceAll('.', ''),
                            );
                            if (amount == null || amount < 50000) {
                              return 'Minimal pembayaran Rp50.000';
                            }
                            return null;
                          },
                        ),
                        _buildInfoBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7C3AED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _submitPayment,
                  child: const Text(
                    'Pay Bill',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildHistory(),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
