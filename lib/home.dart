import 'package:flutter/material.dart';
import 'package:tugas/kirim_uang.dart';
import 'package:tugas/minta_uang.dart';
import 'package:tugas/settings.dart';
import 'profile.dart';
import 'inbox.dart';
import 'history.dart';
import 'pocket.dart';
import 'qris.dart';
import 'withdraw.dart';
import 'taxes.dart';
import 'loan.dart';
import 'creditcard.dart';
import 'beneficiary.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const History(),
    const QrisPage(),
    const Pocket(),
    const ProfilePagee(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildNavigationDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'CashEase',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to your digital wallet',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 0);
            },
          ),
          _buildDrawerItem(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 4);
            },
          ),
          _buildDrawerItem(
            icon: Icons.account_balance_wallet,
            title: 'My Pocket',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3);
            },
          ),
          _buildDrawerItem(
            icon: Icons.history,
            title: 'Transaction History',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 1);
            },
          ),
          const Divider(),
          _buildDrawerSection('Services'),
          _buildDrawerItem(
            icon: Icons.attach_money,
            title: 'Send Money',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KirimUangApp()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.request_page,
            title: 'Request Money',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BagiUangApp()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.qr_code_scanner,
            title: 'QR Scanner',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 2);
            },
          ),
          _buildDrawerItem(
            icon: Icons.atm,
            title: 'Withdraw',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WithdrawPage()),
              );
            },
          ),
          const Divider(),
          _buildDrawerSection('Financial'),
          _buildDrawerItem(
            icon: Icons.receipt_long,
            title: 'Taxes',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaxesPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.account_balance,
            title: 'Loans',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoanPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.savings,
            title: 'Savings',
            onTap: () {
              // Placeholder
            },
          ),
          const Divider(),
          _buildDrawerSection('Utilities'),
          _buildDrawerItem(
            icon: Icons.receipt,
            title: 'Bill Payments',
            onTap: () {
              // Placeholder
            },
          ),
          _buildDrawerItem(
            icon: Icons.phone_android,
            title: 'Mobile Prepaid',
            onTap: () {
              // Placeholder
            },
          ),
          _buildDrawerItem(
            icon: Icons.mail,
            title: 'Inbox',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Inbox()),
              );
            },
          ),
          const Divider(),
          _buildDrawerSection('Support'),
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              // Placeholder
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                // Add logout logic here
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 20,
            ),
          ),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: "Pocket",
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      ],
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeHeaderBody();
  }
}

class HomeHeaderBody extends StatefulWidget {
  const HomeHeaderBody({super.key});

  @override
  State<HomeHeaderBody> createState() => _HomeHeaderBodyState();
}

class _HomeHeaderBodyState extends State<HomeHeaderBody> {
  bool _isAmountVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPurpleHeader(),
        Expanded(child: SingleChildScrollView(child: _buildMenuGrid())),
      ],
    );
  }

  Widget _buildPurpleHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(color: Colors.deepPurple),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.2 * 255).toInt()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'CashEase',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Inbox()),
                      ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _isAmountVisible ? 'Rp. 15.000.000' : '••••••••••••',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap:
                      () =>
                          setState(() => _isAmountVisible = !_isAmountVisible),
                  child: Icon(
                    _isAmountVisible ? Icons.lock_open : Icons.lock_outline,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildHeaderButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeaderButton(Icons.qr_code_scanner, 'Pindai', () {}),
        _buildHeaderButton(Icons.add, 'Isi Saldo', () {}),
        _buildHeaderButton(Icons.attach_money, 'Kirim', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KirimUangApp()),
          );
        }),
        _buildHeaderButton(Icons.request_page, 'Minta', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BagiUangApp()),
          );
        }),
      ],
    );
  }

  Widget _buildHeaderButton(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withAlpha((0.6 * 255).toInt()),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  void _showTaxesLoanDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Option',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TaxesPage()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.receipt_long,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Taxes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Pay your tax obligations',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepPurple,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoanPage()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Manage your loan payments',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.credit_card_outlined,
        'text': 'Accept and\nCard',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.swap_horiz,
        'text': 'Transfer',
        'color': Colors.red.shade400,
        'bgColor': Colors.red.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.atm_outlined,
        'text': 'Withdraw',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
        'onTap':
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WithdrawPage()),
            ),
      },
      {
        'icon': Icons.sim_card_outlined,
        'text': 'Mobile\nPrepaid',
        'color': Colors.amber,
        'bgColor': Colors.amber.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.receipt_outlined,
        'text': 'Pay the\nBill',
        'color': Colors.teal,
        'bgColor': Colors.teal.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.savings_outlined,
        'text': 'Save\nonline',
        'color': Colors.indigo,
        'bgColor': Colors.indigo.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.credit_card_outlined,
        'text': 'Credit\nCard',
        'color': Colors.orange,
        'bgColor': Colors.orange.shade50,
        'onTap':
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditCardPaymentPage()),
            ),
      },
      {
        'icon': Icons.receipt_long_outlined,
        'text': 'Transaction\nReport',
        'color': Colors.blue.shade700,
        'bgColor': Colors.blue.shade50,
        'onTap': () {},
      },
      {
        'icon': Icons.person_add_outlined,
        'text': 'Beneficiary',
        'color': Colors.pink,
        'bgColor': Colors.pink.shade50,
        'onTap':
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BeneficiaryPage()),
            ),
      },
      {
        'icon': Icons.account_balance_outlined,
        'text': 'Taxes/Loan',
        'color': Colors.black,
        'bgColor': Colors.grey.shade100,
        'onTap': () => _showTaxesLoanDrawer(context),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: List.generate((menuItems.length / 3).ceil(), (rowIndex) {
          final startIndex = rowIndex * 3;
          final endIndex =
              (startIndex + 3 > menuItems.length)
                  ? menuItems.length
                  : startIndex + 3;
          final rowItems = menuItems.sublist(startIndex, endIndex);
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  rowItems.map((item) => _buildMenuItemSquare(item)).toList()
                    ..addAll(
                      List.generate(3 - rowItems.length, (_) => const Spacer()),
                    ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuItemSquare(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: item['onTap'],
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: item['bgColor'],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(item['icon'], color: item['color'], size: 30),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['text'],
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
