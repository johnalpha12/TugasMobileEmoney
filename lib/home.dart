import 'package:flutter/material.dart';
import 'package:tugas/kirim_uang.dart';
import 'package:tugas/minta_uang.dart';
import 'profile.dart';
import 'inbox.dart';
import 'history.dart';
import 'pocket.dart';
import 'qris.dart';
import 'withdraw.dart';

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
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
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
        const BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
          ),
          label: "",
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Pocket"),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Inbox()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.mail, color: Colors.white, size: 16),
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
                  onTap: () {
                    setState(() {
                      _isAmountVisible = !_isAmountVisible;
                    });
                  },
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
                color: Colors.white.withOpacity(0.6),
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

  Widget _buildMenuGrid() {
    // Explicitly define the type for onTap to be VoidCallback? (nullable)
    // This helps the Dart analyzer understand that 'onTap' is a function.
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.credit_card_outlined, 'text': 'Accept and\nCard', 'color': Colors.blue, 'bgColor': Colors.blue.shade50, 'onTap': () {}},
      {'icon': Icons.swap_horiz, 'text': 'Transfer', 'color': Colors.red.shade400, 'bgColor': Colors.red.shade50, 'onTap': () {}},
      {
        'icon': Icons.atm_outlined,
        'text': 'Withdraw',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WithdrawPage()), // Target your WithdrawPage widget
          );
        },
      },
      {'icon': Icons.sim_card_outlined, 'text': 'Mobile\nPrepaid', 'color': Colors.amber, 'bgColor': Colors.amber.shade50, 'onTap': () {}},
      {'icon': Icons.receipt_outlined, 'text': 'Pay the\nBill', 'color': Colors.teal, 'bgColor': Colors.teal.shade50, 'onTap': () {}},
      {'icon': Icons.savings_outlined, 'text': 'Save\nonline', 'color': Colors.indigo, 'bgColor': Colors.indigo.shade50, 'onTap': () {}},
      {'icon': Icons.credit_card_outlined, 'text': 'Credit\nCard', 'color': Colors.orange, 'bgColor': Colors.orange.shade50, 'onTap': () {}},
      {'icon': Icons.receipt_long_outlined, 'text': 'Transaction\nReport', 'color': Colors.blue.shade700, 'bgColor': Colors.blue.shade50, 'onTap': () {}},
      {'icon': Icons.person_add_outlined, 'text': 'Beneficiary', 'color': Colors.pink, 'bgColor': Colors.pink.shade50, 'onTap': () {}},
      {'icon': Icons.account_balance_outlined, 'text': 'Taxes/Loan', 'color': Colors.black, 'bgColor': Colors.grey.shade100, 'onTap': () {}},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: List.generate(4, (rowIndex) {
          final startIndex = rowIndex * 3;
          final endIndex = (startIndex + 3 > menuItems.length) ? menuItems.length : startIndex + 3;
          final rowItems = menuItems.sublist(startIndex, endIndex);
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowItems.map((item) => _buildMenuItemSquare(item)).toList()
                ..addAll(List.generate(3 - rowItems.length, (_) => const Spacer())),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuItemSquare(Map<String, dynamic> item) {
    // Wrap the entire item with GestureDetector to make it tappable.
    return GestureDetector(
      onTap: item['onTap'], // Use the onTap function defined in the menuItems list
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