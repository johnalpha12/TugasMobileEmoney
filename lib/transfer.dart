import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'passwordScreen.dart';

class Transfer {
  String name;
  String bankName;
  String accountNumber;
  String logoAssetPath;
  String alias;

  Transfer({
    required this.name,
    required this.bankName,
    required this.accountNumber,
    required this.logoAssetPath,
    this.alias = '',
  });
}

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {

  String _formatCurrency(int number) {
  final result = number.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
  return 'Rp $result';
}

  final List<Transfer> _beneficiaries = [
    Transfer(
      name: 'John Doe',
      bankName: 'Bank BCA',
      accountNumber: '1234567890',
      logoAssetPath: 'asset/elogo1.png',
      alias: 'Ayah',
    ),
    Transfer(
      name: 'Jane Smith',
      bankName: 'Bank Mandiri',
      accountNumber: '0987654321',
      logoAssetPath: 'asset/elogo2.png',
      alias: 'Ibu',
    ),
    Transfer(
      name: 'Michael Johnson',
      bankName: 'Bank BNI',
      accountNumber: '1122334455',
      logoAssetPath: 'asset/elogo5.png',
      alias: 'Toko Kelontong',
    ),
    Transfer(
      name: 'Emily Davis',
      bankName: 'Dana',
      accountNumber: '08123456789',
      logoAssetPath: 'asset/elogo3.png',
    ),
  ];

  List<Transfer> _filteredBeneficiaries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredBeneficiaries = _beneficiaries;
    _searchController.addListener(_filterBeneficiaries);
  }

  void _filterBeneficiaries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBeneficiaries = _beneficiaries.where((b) {
        return b.name.toLowerCase().contains(query) ||
            b.accountNumber.contains(query) ||
            b.alias.toLowerCase().contains(query);
      }).toList();
    });
  }

void _showTransferDialog(Transfer transfer) {
  final TextEditingController _amountController = TextEditingController();
  final ValueNotifier<String> formattedAmount = ValueNotifier('');
  final _formKey = GlobalKey<FormState>();
  final rootContext = context;

  void updateFormattedAmount(String value) {
    final amount = int.tryParse(value.replaceAll('.', ''));
    if (amount != null && amount > 0) {
      formattedAmount.value = _formatCurrency(amount);
    } else {
      formattedAmount.value = '';
    }
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Transfer Uang'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: 'Masukkan jumlah (Rp)'),
              onChanged: updateFormattedAmount,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Masukkan jumlah';
                final amount = int.tryParse(value);
                if (amount == null || amount <= 0) return 'Jumlah tidak valid';
                return null;
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<String>(
              valueListenable: formattedAmount,
              builder: (_, value, __) {
                return Text(
                  value.isNotEmpty ? 'Jumlah: $value' : '',
                  style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final amount = int.parse(_amountController.text);
              Navigator.pop(context);

              final verified = await Navigator.push<bool>(
                rootContext,
                MaterialPageRoute(builder: (_) => const PasswordScreen()),
              );

              if (verified == true && mounted) {
                _showTransferSuccessBanner(rootContext, amount, transfer.name);
              }
            }
          },
          child: const Text('Transfer'),
        ),
      ],
    ),
  );
}


  void _showTransferSuccessBanner(BuildContext context, int amount, String name) {
    ScaffoldMessenger.of(context).clearMaterialBanners();

    final banner = MaterialBanner(
      backgroundColor: Colors.green.shade600,
      content: Text(
        'Transfer Rp $amount ke $name berhasil.',
        style: const TextStyle(color: Colors.white),
      ),
      leading: const Icon(Icons.check_circle, color: Colors.white),
      actions: [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          child: const Text('TUTUP', style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }

  void _deleteTransfer(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Penerima'),
        content: Text('Anda yakin ingin menghapus ${_beneficiaries[index].name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              setState(() {
                _beneficiaries.removeAt(index);
                _filterBeneficiaries();
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _navigateToAddTransfer() async {
    final newTransfer = await Navigator.push<Transfer>(
      context,
      MaterialPageRoute(builder: (_) => const AddTransferPage()),
    );

    if (newTransfer != null) {
      setState(() {
        _beneficiaries.add(newTransfer);
        _filterBeneficiaries();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _filteredBeneficiaries.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredBeneficiaries.length,
                    itemBuilder: (context, index) {
                      final transfer = _filteredBeneficiaries[index];
                      return _buildTransferCard(transfer, index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransfer,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari nama, alias, atau rekening...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTransferCard(Transfer transfer, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(transfer.logoAssetPath),
        ),
        title: Text(transfer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "${transfer.alias.isNotEmpty ? '${transfer.alias} • ' : ''}${transfer.bankName} - ${transfer.accountNumber}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.money, color: Color.fromARGB(255, 9, 215, 9), size: 20),
              onPressed: () => _showTransferDialog(transfer),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => _deleteTransfer(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text('Belum Ada Penerima', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Text('Tekan tombol + untuk menambah penerima baru.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}



class AddTransferPage extends StatefulWidget {
  const AddTransferPage({super.key});

  @override
  State<AddTransferPage> createState() => _AddTransferPageState();
}

class _AddTransferPageState extends State<AddTransferPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _aliasController = TextEditingController();

  String? _selectedBank;
  final List<Map<String, String>> _banks = [
    {'name': 'Bank BCA', 'logo': 'asset/elogo1.png'},
    {'name': 'Bank Mandiri', 'logo': 'asset/elogo2.png'},
    {'name': 'Bank BNI', 'logo': 'asset/elogo5.png'},
    {'name': 'Permata Bank', 'logo': 'asset/elogo4.png'},
    {'name': 'Dana', 'logo': 'asset/elogo3.png'},
  ];

  String _getLogoPath(String bankName) {
    switch (bankName) {
      case 'Bank BCA':
        return 'asset/elogo1.png';
      case 'Bank Mandiri':
        return 'asset/elogo2.png';
      case 'Bank BNI':
        return 'asset/elogo5.png';
      case 'Dana':
        return 'asset/elogo3.png';
      default:
        return 'asset/elogo1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Tambah Penerima', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _accountNumberController,
                decoration: const InputDecoration(labelText: 'Nomor Rekening'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Pilih Bank'),
                value: _selectedBank,
                items: _banks.map((bank) {
                    return DropdownMenuItem(
                      value: bank['name'],
                      child: Row(
                        children: [
                          Image.asset(bank['logo']!, width: 24),
                          const SizedBox(width: 10),
                          Text(bank['name']!),
                        ],
                      ),
                    );
                  }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Pilih bank' : null,
              ),
              TextFormField(
                controller: _aliasController,
                decoration: const InputDecoration(labelText: 'Alias (opsional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTransfer = Transfer(
                      name: _nameController.text,
                      alias: _aliasController.text,
                      bankName: _selectedBank!,
                      accountNumber: _accountNumberController.text,
                      logoAssetPath: _getLogoPath(_selectedBank!),
                    );
                    Navigator.pop(context, newTransfer);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
