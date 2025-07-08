import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'modeltabungan.dart';

class EditTabungan extends StatefulWidget {
  final SavingGoal? goal;
  const EditTabungan({Key? key, this.goal}) : super(key: key);

  @override
  State<EditTabungan> createState() => _EditTabunganState();
}

class _EditTabunganState extends State<EditTabungan> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _initialDepositController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.goal?.title ?? '');
    _amountController = TextEditingController(
      text:
          widget.goal?.amount != null ? _formatNumber(widget.goal!.amount) : '',
    );
    _initialDepositController = TextEditingController(
      text:
          widget.goal != null
              ? _formatNumber(
                (widget.goal!.amount * widget.goal!.progress).toInt(),
              )
              : '',
    );
    _descriptionController = TextEditingController(
      text: widget.goal?.description ?? '',
    );
    _selectedDate = widget.goal?.targetDate;
  }

  String _formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _initialDepositController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      final int target =
          int.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;
      final int initial =
          int.tryParse(_initialDepositController.text.replaceAll(',', '')) ?? 0;

      final newGoal = SavingGoal(
        title: _titleController.text.trim(),
        amount: target,
        progress: target > 0 ? (initial / target).clamp(0.0, 1.0) : 0.0,
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        targetDate: _selectedDate,
      );
      Navigator.pop(context, newGoal);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.goal == null ? 'Tambah Tabungan' : 'Edit Tabungan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Nama Tabungan'),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Masukkan nama tabungan'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Target (Rp)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _ThousandsSeparatorInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'Masukkan jumlah target';
                  final clean = value.replaceAll(',', '');
                  final amount = int.tryParse(clean);
                  if (amount == null || amount <= 0)
                    return 'Masukkan jumlah yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _initialDepositController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Setoran Awal (Rp)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _ThousandsSeparatorInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'Masukkan setoran awal';
                  final clean = value.replaceAll(',', '');
                  final amount = int.tryParse(clean);
                  if (amount == null || amount <= 0)
                    return 'Masukkan jumlah yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (Opsional)',
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'Pilih tanggal target'
                      : 'Target: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveGoal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom TextInputFormatter untuk separator ribuan
class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[digits.length - 1 - i]);
      if ((i + 1) % 3 == 0 && i + 1 != digits.length) {
        buffer.write(',');
      }
    }

    final formatted = buffer.toString().split('').reversed.join();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
