import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_profile.dart';
import 'edit_tabungan.dart';
import 'modeltabungan.dart';

class ProfilePage extends StatefulWidget {
  final bool isPushed;

  const ProfilePage({super.key, this.isPushed = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState(); // Perbaiki nama state
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Agus Salim";
  String phoneNumber = "082134410085";
  String email = "agussalim@gmail.com";
  String gender = "Pria";
  double balance = 300000;
  double income = 2800000;
  double expense = 1500000;
  bool _showEditIcon = false;

  List<SavingGoal> savingGoals = [
    SavingGoal(
      title: "Cicil KPR Rumah",
      amount: 5200000,
      progress: 0.22,
      description: "DP rumah 20%",
      targetDate: DateTime(2025, 12, 31),
    ),
    SavingGoal(
      title: "Tabungan Darurat",
      amount: 25700000,
      progress: 0.71,
      description: "Dana darurat 6 bulan",
      targetDate: DateTime(2024, 6, 30),
    ),
    SavingGoal(
      title: "Beli Monitor",
      amount: 2400000,
      progress: 0.83,
      description: "Monitor 27 inch 4K",
      targetDate: DateTime(2024, 3, 15),
    ),
  ];

  void _showQRCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'QR PROFIL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              phoneNumber.replaceRange(
                4,
                phoneNumber.length - 2,
                '*' * (phoneNumber.length - 6),
              ),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'asset/kodeqr.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Ajak teman yang ada didekat kamu memindai\nkode QR ini untuk memulai transaksi.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Tutup",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(
          firstName: userName.split(" ")[0],
          lastName: userName.contains(" ") ? userName.substring(userName.indexOf(" ") + 1) : "",
          phoneNumber: phoneNumber,
          email: email,
          gender: gender,
        ),
      ),
    );

    if (result is Map<String, dynamic>) {
      setState(() {
        userName = "${result['firstName']} ${result['lastName']}";
        phoneNumber = result['phoneNumber'];
        email = result['email'];
        gender = result['gender'];
      });
    }
  }

  void _navigateToAddSaving() async {
    final newGoal = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditTabungan()),
    );

    if (newGoal is SavingGoal) {
      setState(() {
        savingGoals.add(newGoal);
      });
    }
  }

  void _navigateToEditSaving(int index) async {
    final updatedGoal = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTabungan(goal: savingGoals[index]),
      ),
    );

    if (updatedGoal is SavingGoal) {
      setState(() {
        savingGoals[index] = updatedGoal;
      });
    }
  }

  void _showGoalDialog(int index) {
    final goal = savingGoals[index];
    final TextEditingController _depositController = TextEditingController();
    final _depositFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jumlah: Rp ${_formatCurrency(goal.amount.toInt())}"),
              Text(
                "Progress: ${(goal.progress * 100).toStringAsFixed(1)}%",
              ),
              if (goal.description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Deskripsi: ${goal.description!}"),
                ),
              if (goal.targetDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Target: ${goal.targetDate!.toIso8601String().split('T')[0]}",
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToEditSaving(index);
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              setState(() => savingGoals.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Tambah Setoran"),
                  content: Form(
                    key: _depositFormKey,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _ThousandsSeparatorInputFormatter(),
                      ],
                      controller: _depositController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Masukkan jumlah setoran';
                        }
                        final clean = value.replaceAll(',', '');
                        final amount = int.tryParse(clean);
                        if (amount == null || amount <= 0) {
                          return 'Masukkan jumlah yang valid';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Masukkan jumlah (Rp)",
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_depositFormKey.currentState!.validate()) {
                          final tambah = int.parse(
                            _depositController.text.replaceAll(',', ''),
                          );
                          setState(() {
                            final currentAmount = (goal.amount * goal.progress).toInt();
                            final newProgress = ((currentAmount + tambah) / goal.amount).clamp(0.0, 1.0);
                            savingGoals[index] = SavingGoal(
                              title: goal.title,
                              amount: goal.amount,
                              progress: newProgress,
                              description: goal.description,
                              targetDate: goal.targetDate,
                            );
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Simpan"),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Tambah Tabungan'),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(int index) {
    final goal = savingGoals[index];
    return GestureDetector(
      onTap: () => _showGoalDialog(index),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      goal.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      goal.targetDate?.toIso8601String().split('T')[0] ?? "Tanpa target",
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.deepPurple.withOpacity(0.1),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Rp ${_formatCurrency((goal.amount * goal.progress).toInt())}",
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: goal.progress,
                color: Colors.deepPurple,
                backgroundColor: Colors.grey[200],
                minHeight: 8,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${(goal.progress * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Rp ${_formatCurrency(goal.amount.toInt())}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  Widget _buildTransactionInfo(
    IconData icon,
    String label,
    double amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              "Rp ${_formatCurrency(amount.toInt())}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPushed
          ? AppBar(
              backgroundColor: Colors.deepPurple,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.1),
              ),
              child: const Text(
                "Personal",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: MouseRegion(
              onEnter: (_) => setState(() => _showEditIcon = true),
              onExit: (_) => setState(() => _showEditIcon = false),
              child: GestureDetector(
                onTap: _navigateToEditProfile,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('asset/foto.png'),
                    ),
                    if (_showEditIcon)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            title: Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              phoneNumber,
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: ElevatedButton(
              onPressed: _showQRCodeDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "QR CODE",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Balance Kamu",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp ${_formatCurrency(balance.toInt())}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "Top Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTransactionInfo(
                                  Icons.arrow_upward,
                                  "Income",
                                  income,
                                  Colors.green,
                                ),
                                _buildTransactionInfo(
                                  Icons.arrow_downward,
                                  "Expense",
                                  expense,
                                  Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tabungan Kamu",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _navigateToAddSaving,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text("Tambah Tabungan Baru"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (savingGoals.isEmpty)
                      Column(
                        children: [
                          const Icon(
                            Icons.savings,
                            size: 60,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Belum ada tabungan",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Tambahkan tabungan baru untuk memulai",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: List.generate(
                          savingGoals.length,
                          (index) => _buildGoalCard(index),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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