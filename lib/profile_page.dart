import 'package:flutter/material.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User data yang dapat diubah
  String userName = "Agus Salim";
  String phoneNumber = "082134410085";
  String email = "agussalim@gmail.com";
  String gender = "Pria"; // Default gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: GestureDetector(
              onTap: () => _navigateToEditProfile(context),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            title: Text(userName, style: const TextStyle(color: Colors.white, fontSize: 18)),
            subtitle: Text(phoneNumber, style: const TextStyle(color: Colors.white70)),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text("QR CODE", style: TextStyle(color: Colors.deepPurple)),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Balance Kamu", style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("RP 300.000",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  child: const Text("Top Up"),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_upward, color: Colors.green),
                                    SizedBox(width: 5),
                                    Text("Income\nRP 2.800.000",
                                        style: TextStyle(color: Colors.green)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_downward, color: Colors.red),
                                    SizedBox(width: 5),
                                    Text("Expense\nRP 1.500.000",
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildGoalCard("Cicil Kpr Rumah", 5200000, 0.22),
                    buildGoalCard("Tabungan", 25700000, 0.71),
                    buildGoalCard("Beli Monitor", 2400000, 0.83),
                    const SizedBox(height: 30),
                    // Tambahkan tombol Switch Account
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.switch_account, color: Colors.deepPurple),
                        label: const Text(
                          "Switch Account",
                          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.deepPurple),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // TODO: Implementasi logika switch account
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Switch Account clicked!')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tambahkan tombol Logout
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // TODO: Implementasi logika logout
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk navigasi ke halaman EditProfile
  Future<void> _navigateToEditProfile(BuildContext context) async {
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

    // Update profil jika data dikembalikan dari halaman edit
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        userName = "${result['firstName']} ${result['lastName']}";
        phoneNumber = result['phoneNumber'];
        email = result['email'];
        gender = result['gender'];
      });
    }
  }

  Widget buildGoalCard(String title, int amount, double progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("CashEase Goals\nYou have 4 goals",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 8),
            Text("Rp ${amount.toString()}",
                style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              color: Colors.deepPurple,
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }
}
