import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAmountVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildPurpleHeader(),
          Expanded(child: SingleChildScrollView(child: _buildMenuGrid())),
          _buildBottomNavBar(),
        ],
      ),
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
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.mail, color: Colors.white, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Updated balance display with lock toggle
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
            _buildHeaderButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeaderButton(Icons.indeterminate_check_box_outlined, 'Pindai'),
        _buildHeaderButton(Icons.add, 'Isi Saldo'),
        _buildHeaderButton(Icons.attach_money, 'Kirim'),
        _buildHeaderButton(Icons.attach_money, 'Minta'),
      ],
    );
  }

  Widget _buildHeaderButton(IconData icon, String text) {
    return Column(
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
    );
  }

  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.credit_card_outlined,
        'text': 'Accept and\nCard',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
      },
      {
        'icon': Icons.swap_horiz,
        'text': 'Transfer',
        'color': Colors.red.shade400,
        'bgColor': Colors.red.shade50,
      },
      {
        'icon': Icons.atm_outlined,
        'text': 'Withdraw',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
      },
      {
        'icon': Icons.sim_card_outlined,
        'text': 'Mobile\nPrepaid',
        'color': Colors.amber,
        'bgColor': Colors.amber.shade50,
      },
      {
        'icon': Icons.receipt_outlined,
        'text': 'Pay the\nBill',
        'color': Colors.teal,
        'bgColor': Colors.teal.shade50,
      },
      {
        'icon': Icons.savings_outlined,
        'text': 'Save\nonline',
        'color': Colors.indigo,
        'bgColor': Colors.indigo.shade50,
      },
      {
        'icon': Icons.credit_card_outlined,
        'text': 'Credit\nCard',
        'color': Colors.orange,
        'bgColor': Colors.orange.shade50,
      },
      {
        'icon': Icons.receipt_long_outlined,
        'text': 'Transaction\nReport',
        'color': Colors.blue.shade700,
        'bgColor': Colors.blue.shade50,
      },
      {
        'icon': Icons.person_add_outlined,
        'text': 'Beneficiary',
        'color': Colors.pink,
        'bgColor': Colors.pink.shade50,
      },
      {
        'icon': Icons.account_balance_outlined,
        'text': 'Taxes/Loan',
        'color': Colors.black,
        'bgColor': Colors.grey.shade100,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMenuItemSquare(menuItems[0]),
              _buildMenuItemSquare(menuItems[1]),
              _buildMenuItemSquare(menuItems[2]),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMenuItemSquare(menuItems[3]),
              _buildMenuItemSquare(menuItems[4]),
              _buildMenuItemSquare(menuItems[5]),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMenuItemSquare(menuItems[6]),
              _buildMenuItemSquare(menuItems[7]),
              _buildMenuItemSquare(menuItems[8]),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              _buildMenuItemSquare(menuItems[9]),
              const Spacer(),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItemSquare(Map<String, dynamic> item) {
    return SizedBox(
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
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', true, Colors.deepPurple),
          _buildNavItem(Icons.history, 'History', false, Colors.grey),
          _buildNavItem(
            Icons.grid_view,
            '',
            false,
            Colors.white,
            isPrimary: true,
          ),
          _buildNavItem(Icons.wallet, 'Pocket', false, Colors.grey),
          _buildNavItem(Icons.person_outline, 'Me', false, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    Color color, {
    bool isPrimary = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isPrimary
            ? Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            )
            : Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.deepPurple : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
