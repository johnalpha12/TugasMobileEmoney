import 'package:flutter/material.dart';
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
    _amountController = TextEditingController(text: widget.goal?.amount.toString() ?? '');
    _initialDepositController = TextEditingController(
      text: widget.goal != null
          ? ((widget.goal!.amount * widget.goal!.progress).toInt()).toString()
          : '',
    );
    _descriptionController = TextEditingController(text: widget.goal?.description ?? '');
    _selectedDate = widget.goal?.targetDate;
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
      final int target = int.tryParse(_amountController.text.trim()) ?? 0;
      final int initial = int.tryParse(_initialDepositController.text.trim()) ?? 0;

      final newGoal = SavingGoal(
        title: _titleController.text.trim(),
        amount: target,
        progress: target > 0 ? (initial / target).clamp(0.0, 1.0) : 0.0,
        description: _descriptionController.text.trim().isEmpty
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
        title: Text(widget.goal == null ? 'Tambah Tabungan' : 'Edit Tabungan', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white), // ← back icon putih
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
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Masukkan nama tabungan'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Jumlah Target (Rp)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Masukkan jumlah target';
                  if (int.tryParse(value) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _initialDepositController,
                decoration: const InputDecoration(labelText: 'Jumlah Setoran Awal (Rp)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Masukkan setoran awal';
                  if (int.tryParse(value) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi (Opsional)'),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
