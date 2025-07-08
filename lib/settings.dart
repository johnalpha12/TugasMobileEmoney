import 'package:flutter/material.dart';
import 'edit_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isBiometricEnabled = true;
  bool _promoNotifications = true;
  bool _transactionNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[50],
      body: ListView(
        children: [
          _buildSectionHeader('Akun'),
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profil',
            subtitle: 'Ubah nama, email, dan nomor telepon',
            onTap: () {
              // Navigasi ke halaman EditProfile yang sudah ada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const EditProfile(
                        firstName: "Agus",
                        lastName: "Salim",
                        phoneNumber: "082134410085",
                        email: "agussalim@gmail.com",
                        gender: "Pria",
                      ),
                ),
              );
            },
          ),
          _buildSettingsTile(
            icon: Icons.shield_outlined,
            title: 'Keamanan Akun',
            subtitle: 'Ubah PIN, atur pertanyaan keamanan',
            onTap: () {
              // TODO: Navigasi ke halaman keamanan
            },
          ),
          _buildSettingsTile(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Akun & Kartu Tersimpan',
            subtitle: 'Atur rekening bank & kartu kredit',
            onTap: () {
              // TODO: Navigasi ke halaman Pocket/Beneficiary
            },
          ),

          const Divider(indent: 20, endIndent: 20),
          _buildSectionHeader('Keamanan'),
          _buildSwitchTile(
            icon: Icons.fingerprint,
            title: 'Login dengan Biometrik',
            subtitle: 'Gunakan sidik jari atau wajah untuk masuk',
            value: _isBiometricEnabled,
            onChanged: (val) {
              setState(() => _isBiometricEnabled = val);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Biometrik ${val ? "diaktifkan" : "dinonaktifkan"}',
                  ),
                ),
              );
            },
          ),
          _buildSettingsTile(
            icon: Icons.phonelink_lock_outlined,
            title: 'Perangkat Terhubung',
            subtitle: 'Lihat dan kelola sesi login aktif',
            onTap: () {
              // TODO: Navigasi ke halaman perangkat terhubung
            },
          ),

          const Divider(indent: 20, endIndent: 20),
          _buildSectionHeader('Notifikasi'),
          _buildSwitchTile(
            icon: Icons.local_offer_outlined,
            title: 'Promo & Penawaran',
            subtitle: 'Dapatkan info promo terbaru',
            value: _promoNotifications,
            onChanged: (val) => setState(() => _promoNotifications = val),
          ),
          _buildSwitchTile(
            icon: Icons.notifications_active_outlined,
            title: 'Aktivitas Transaksi',
            subtitle: 'Notifikasi untuk setiap transaksi',
            value: _transactionNotifications,
            onChanged: (val) => setState(() => _transactionNotifications = val),
          ),

          const Divider(indent: 20, endIndent: 20),
          _buildSectionHeader('Info'),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Pusat Bantuan',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Versi 1.0.0',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.logout,
            title: 'Keluar',
            isDestructive: true,
            onTap: () {
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red : Colors.black87;
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: const TextStyle(fontSize: 12))
              : null,
      trailing:
          isDestructive ? null : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.deepPurple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: const TextStyle(fontSize: 12))
              : null,
      value: value,
      onChanged: onChanged,
      activeColor: Colors.deepPurple,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Keluar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil keluar!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
