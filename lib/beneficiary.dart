import 'package:flutter/material.dart';

// Model untuk data beneficiary
class Beneficiary {
  String name;
  String bankName;
  String accountNumber;
  String logoAssetPath;
  String alias;

  Beneficiary({
    required this.name,
    required this.bankName,
    required this.accountNumber,
    required this.logoAssetPath,
    this.alias = '',
  });
}

class BeneficiaryPage extends StatefulWidget {
  const BeneficiaryPage({super.key});

  @override
  State<BeneficiaryPage> createState() => _BeneficiaryPageState();
}

class _BeneficiaryPageState extends State<BeneficiaryPage> {
  // Data dummy untuk daftar beneficiary
  final List<Beneficiary> _beneficiaries = [
    Beneficiary(
      name: 'John Doe',
      bankName: 'Bank BCA',
      accountNumber: '1234567890',
      logoAssetPath: 'asset/elogo1.png',
      alias: 'Ayah',
    ),
    Beneficiary(
      name: 'Jane Smith',
      bankName: 'Bank Mandiri',
      accountNumber: '0987654321',
      logoAssetPath: 'asset/elogo2.png',
      alias: 'Ibu',
    ),
    Beneficiary(
      name: 'Michael Johnson',
      bankName: 'Bank BNI',
      accountNumber: '1122334455',
      logoAssetPath: 'asset/elogo5.png',
      alias: 'Toko Kelontong',
    ),
    Beneficiary(
      name: 'Emily Davis',
      bankName: 'Dana',
      accountNumber: '08123456789',
      logoAssetPath: 'asset/elogo3.png',
    ),
  ];

  List<Beneficiary> _filteredBeneficiaries = [];
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
      _filteredBeneficiaries =
          _beneficiaries.where((b) {
            return b.name.toLowerCase().contains(query) ||
                b.accountNumber.contains(query) ||
                b.alias.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addOrEditBeneficiary([Beneficiary? beneficiary, int? index]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditBeneficiaryPage(beneficiary: beneficiary),
      ),
    );

    if (result is Beneficiary) {
      setState(() {
        if (index != null) {
          // Edit
          _beneficiaries[index] = result;
        } else {
          // Add
          _beneficiaries.add(result);
        }
        _filterBeneficiaries();
      });
    }
  }

  void _deleteBeneficiary(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hapus Penerima'),
            content: Text(
              'Anda yakin ingin menghapus ${_beneficiaries[index].name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Penerima',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child:
                _filteredBeneficiaries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _filteredBeneficiaries.length,
                      itemBuilder: (context, index) {
                        final beneficiary = _filteredBeneficiaries[index];
                        return _buildBeneficiaryCard(beneficiary, index);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditBeneficiary(),
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

  Widget _buildBeneficiaryCard(Beneficiary beneficiary, int originalIndex) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(beneficiary.logoAssetPath),
        ),
        title: Text(
          beneficiary.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${beneficiary.alias.isNotEmpty ? '${beneficiary.alias} • ' : ''}${beneficiary.bankName} - ${beneficiary.accountNumber}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue.shade700, size: 20),
              onPressed:
                  () => _addOrEditBeneficiary(
                    beneficiary,
                    _beneficiaries.indexOf(beneficiary),
                  ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade700, size: 20),
              onPressed:
                  () => _deleteBeneficiary(_beneficiaries.indexOf(beneficiary)),
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
          const Text(
            'Belum Ada Penerima',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tekan tombol + untuk menambah penerima baru.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// Halaman untuk Tambah/Edit Beneficiary
class AddEditBeneficiaryPage extends StatefulWidget {
  final Beneficiary? beneficiary;

  const AddEditBeneficiaryPage({super.key, this.beneficiary});

  @override
  _AddEditBeneficiaryPageState createState() => _AddEditBeneficiaryPageState();
}

class _AddEditBeneficiaryPageState extends State<AddEditBeneficiaryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _aliasController;
  String? _selectedBank;

  final List<Map<String, String>> _banks = [
    {'name': 'Bank BCA', 'logo': 'asset/elogo1.png'},
    {'name': 'Bank Mandiri', 'logo': 'asset/elogo2.png'},
    {'name': 'Bank BNI', 'logo': 'asset/elogo5.png'},
    {'name': 'Permata Bank', 'logo': 'asset/elogo4.png'},
    {'name': 'Dana', 'logo': 'asset/elogo3.png'},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.beneficiary?.name ?? '',
    );
    _accountNumberController = TextEditingController(
      text: widget.beneficiary?.accountNumber ?? '',
    );
    _aliasController = TextEditingController(
      text: widget.beneficiary?.alias ?? '',
    );
    _selectedBank = widget.beneficiary?.bankName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.beneficiary == null ? 'Tambah Penerima' : 'Edit Penerima',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBank,
              hint: const Text('Pilih Bank atau E-Wallet'),
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items:
                  _banks.map((bank) {
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
              onChanged: (value) => setState(() => _selectedBank = value),
              validator:
                  (value) => value == null ? 'Pilih salah satu bank' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Nomor Rekening / Telepon',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator:
                  (value) => value!.isEmpty ? 'Nomor tidak boleh kosong' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Pemilik Rekening',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _aliasController,
              decoration: const InputDecoration(
                labelText: 'Alias / Nama Panggilan (Opsional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final selectedBankData = _banks.firstWhere(
        (b) => b['name'] == _selectedBank,
      );
      final beneficiary = Beneficiary(
        name: _nameController.text,
        bankName: _selectedBank!,
        accountNumber: _accountNumberController.text,
        logoAssetPath: selectedBankData['logo']!,
        alias: _aliasController.text,
      );
      Navigator.pop(context, beneficiary);
    }
  }
}
