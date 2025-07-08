import 'package:flutter/material.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  String selectedTerm = '12 months';
  String selectedType = 'Personal Loan';
  bool isApplicationSubmitted = false;

  final List<String> loanTerms = [
    '6 months',
    '12 months',
    '24 months',
    '36 months',
  ];
  final List<String> loanTypes = [
    'Personal Loan',
    'Business Loan',
    'Emergency Loan',
  ];

  // Dynamic lists for active loans and history
  List<Map<String, dynamic>> activeLoans = [
    {
      'id': 'LN001',
      'type': 'Personal Loan',
      'amount': 5000000,
      'remaining': 3200000,
      'monthlyPayment': 450000,
      'nextDue': '2025-07-15',
      'progress': 0.36,
      'term': '12 months',
      'purpose': 'Home renovation',
      'applicationDate': '2024-12-01',
    },
    {
      'id': 'LN002',
      'type': 'Emergency Loan',
      'amount': 2000000,
      'remaining': 800000,
      'monthlyPayment': 200000,
      'nextDue': '2025-07-10',
      'progress': 0.6,
      'term': '12 months',
      'purpose': 'Medical emergency',
      'applicationDate': '2024-11-15',
    },
  ];

  // Payment history for tracking all payments
  List<Map<String, dynamic>> paymentHistory = [];

  List<Map<String, dynamic>> loanHistory = [
    {
      'id': 'LN003',
      'type': 'Personal Loan',
      'amount': 3000000,
      'status': 'Completed',
      'date': '2024-12-15',
      'term': '12 months',
      'purpose': 'Education',
    },
    {
      'id': 'LN004',
      'type': 'Emergency Loan',
      'amount': 1500000,
      'status': 'Completed',
      'date': '2024-10-20',
      'term': '6 months',
      'purpose': 'Car repair',
    },
    {
      'id': 'LN005',
      'type': 'Business Loan',
      'amount': 8000000,
      'status': 'Rejected',
      'date': '2024-09-10',
      'term': '24 months',
      'purpose': 'Business expansion',
    },
  ];

  int _loanCounter = 6; // Counter for generating new loan IDs

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Loan Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Apply'),
            Tab(text: 'Active'),
            Tab(text: 'History'),
            Tab(text: 'Payments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildApplyTab(),
          _buildActiveLoansTab(),
          _buildHistoryTab(),
          _buildPaymentHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildApplyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoanInfoCard(),
          const SizedBox(height: 20),
          _buildApplicationForm(),
        ],
      ),
    );
  }

  Widget _buildLoanInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Loan Application',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Get approved in minutes with competitive rates',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildInfoItem('Rate from', '4.5%'),
              const SizedBox(width: 30),
              _buildInfoItem('Max Amount', 'Rp 50M'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Loan Application',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _buildDropdown('Loan Type', selectedType, loanTypes, (value) {
            setState(() => selectedType = value!);
          }),
          const SizedBox(height: 15),

          _buildTextField(
            'Loan Amount',
            _amountController,
            TextInputType.number,
          ),
          const SizedBox(height: 15),

          _buildDropdown('Loan Term', selectedTerm, loanTerms, (value) {
            setState(() => selectedTerm = value!);
          }),
          const SizedBox(height: 15),

          _buildTextField('Purpose', _purposeController, TextInputType.text),
          const SizedBox(height: 25),

          if (isApplicationSubmitted)
            _buildSuccessMessage()
          else
            _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
          ),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: label.contains('Amount') ? _formatCurrencyInput : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            prefixText: label.contains('Amount') ? 'Rp ' : null,
            prefixStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitApplication,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Submit Application',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Application submitted successfully! Loan has been approved and added to your active loans.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _resetForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Apply for Another Loan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitApplication() {
    if (_amountController.text.isEmpty || _purposeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Validate minimum amount
    String amountText = _amountController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    if (amountText.isNotEmpty) {
      int amount = int.parse(amountText);
      if (amount < 500000) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimum loan amount is Rp 500,000')),
        );
        return;
      }

      // Create new loan
      _createNewLoan(amount);
    }

    setState(() => isApplicationSubmitted = true);
  }

  void _createNewLoan(int amount) {
    String loanId = 'LN${_loanCounter.toString().padLeft(3, '0')}';
    String currentDate = DateTime.now().toString().substring(0, 10);
    String nextDueDate = DateTime.now()
        .add(const Duration(days: 30))
        .toString()
        .substring(0, 10);

    // Calculate monthly payment (simplified calculation)
    int termMonths = int.parse(selectedTerm.split(' ')[0]);
    double monthlyPayment = amount / termMonths;

    // Create new active loan
    Map<String, dynamic> newActiveLoan = {
      'id': loanId,
      'type': selectedType,
      'amount': amount,
      'remaining': amount,
      'monthlyPayment': monthlyPayment.round(),
      'nextDue': nextDueDate,
      'progress': 0.0,
      'term': selectedTerm,
      'purpose': _purposeController.text,
      'applicationDate': currentDate,
    };

    // Create new history entry
    Map<String, dynamic> newHistoryEntry = {
      'id': loanId,
      'type': selectedType,
      'amount': amount,
      'status': 'Approved',
      'date': currentDate,
      'term': selectedTerm,
      'purpose': _purposeController.text,
    };

    setState(() {
      activeLoans.add(newActiveLoan);
      loanHistory.insert(0, newHistoryEntry); // Add to beginning of history
      _loanCounter++;
    });
  }

  void _resetForm() {
    setState(() {
      isApplicationSubmitted = false;
      _amountController.clear();
      _purposeController.clear();
      selectedTerm = '12 months';
      selectedType = 'Personal Loan';
    });
  }

  Widget _buildActiveLoansTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Loans',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${activeLoans.length} loans',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (activeLoans.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.account_balance,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active loans',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            ...activeLoans.map((loan) => _buildLoanCard(loan)).toList(),
        ],
      ),
    );
  }

  Widget _buildLoanCard(Map<String, dynamic> loan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loan['type'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                loan['id'],
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Purpose: ${loan['purpose']}',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp ${_formatCurrency(loan['amount'])}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp ${_formatCurrency(loan['remaining'])}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          LinearProgressIndicator(
            value: loan['progress'],
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Payment: Rp ${_formatCurrency(loan['monthlyPayment'])}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Next Due: ${loan['nextDue']}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _makePayment(loan['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Make Payment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Loan History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${loanHistory.length} records',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (loanHistory.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Icon(Icons.history, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No loan history',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            ...loanHistory
                .map(
                  (loan) => _buildHistoryItem(
                    loan['type'],
                    loan['id'],
                    loan['status'],
                    loan['date'],
                    loan['amount'],
                    loan['purpose'],
                  ),
                )
                .toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String type,
    String id,
    String status,
    String date,
    int amount,
    String purpose,
  ) {
    Color statusColor =
        status == 'Completed' || status == 'Approved'
            ? Colors.green
            : status == 'Rejected'
            ? Colors.red
            : Colors.orange;

    IconData statusIcon =
        status == 'Completed' || status == 'Approved'
            ? Icons.check_circle
            : status == 'Rejected'
            ? Icons.cancel
            : Icons.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withAlpha((0.1 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '$id • $date',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                Text(
                  'Purpose: $purpose',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rp ${_formatCurrency(amount)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${paymentHistory.length} records',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (paymentHistory.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Icon(Icons.payment, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No payment history',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            ...paymentHistory
                .map((payment) => _buildPaymentHistoryItem(payment))
                .toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem(Map<String, dynamic> payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan ID: ${payment['loanId']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('Type: ${payment['loanType']}'),
              const SizedBox(height: 4),
              Text('Date: ${payment['date']}'),
            ],
          ),
          Text(
            'Rp ${_formatCurrency(payment['amount'])}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _formatCurrencyInput(String value) {
    if (value.isEmpty) return;

    // Remove all non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) return;

    // Format with commas
    String formatted = _formatCurrency(int.parse(digitsOnly));

    // Update controller without triggering onChanged again
    _amountController.removeListener(() {});
    _amountController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _makePayment(String loanId) {
    // Find the loan
    int loanIndex = activeLoans.indexWhere((loan) => loan['id'] == loanId);
    if (loanIndex == -1) return;

    Map<String, dynamic> loan = activeLoans[loanIndex];
    int monthlyPayment = loan['monthlyPayment'];
    int remaining = loan['remaining'];

    TextEditingController paymentController = TextEditingController();
    paymentController.text = _formatCurrency(monthlyPayment);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Make Payment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Loan ID: ${loan['id']}'),
                Text('Type: ${loan['type']}'),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Payment: Rp ${_formatCurrency(monthlyPayment)}',
                      ),
                      Text(
                        'Remaining Balance: Rp ${_formatCurrency(remaining)}',
                      ),
                      Text('Next Due: ${loan['nextDue']}'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Payment Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: paymentController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isEmpty) return;
                    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                    if (digitsOnly.isEmpty) return;
                    String formatted = _formatCurrency(int.parse(digitsOnly));
                    paymentController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          paymentController.text = _formatCurrency(
                            monthlyPayment,
                          );
                        },
                        child: const Text('Monthly Payment'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          paymentController.text = _formatCurrency(remaining);
                        },
                        child: const Text('Pay Full'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Pay Now'),
              onPressed: () {
                String paymentText = paymentController.text.replaceAll(
                  RegExp(r'[^0-9]'),
                  '',
                );
                if (paymentText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter payment amount'),
                    ),
                  );
                  return;
                }
                int paymentAmount = int.parse(paymentText);
                if (paymentAmount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment amount must be greater than 0'),
                    ),
                  );
                  return;
                }
                if (paymentAmount > remaining) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Payment amount cannot exceed remaining balance',
                      ),
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                _processPayment(loanId, paymentAmount);
              },
            ),
          ],
        );
      },
    );
  }

  void _processPayment(String loanId, int paymentAmount) {
    setState(() {
      // Find the loan
      int loanIndex = activeLoans.indexWhere((loan) => loan['id'] == loanId);
      if (loanIndex == -1) return;

      Map<String, dynamic> loan = activeLoans[loanIndex];
      int currentRemaining = loan['remaining'];
      int totalAmount = loan['amount'];

      // Calculate new remaining balance
      int newRemaining = currentRemaining - paymentAmount;

      // Update next due date (add 1 month)
      DateTime currentDue = DateTime.parse(loan['nextDue']);
      DateTime newDue = DateTime(
        currentDue.year,
        currentDue.month + 1,
        currentDue.day,
      );
      String newDueString = newDue.toString().substring(0, 10);

      // Add payment to payment history
      paymentHistory.insert(0, {
        'loanId': loanId,
        'loanType': loan['type'],
        'amount': paymentAmount,
        'date': DateTime.now().toString().substring(0, 10),
        'remainingAfter': newRemaining,
      });

      if (newRemaining <= 0) {
        // Loan is fully paid
        newRemaining = 0;

        // Move loan to completed in history
        int historyIndex = loanHistory.indexWhere((h) => h['id'] == loanId);
        if (historyIndex != -1) {
          loanHistory[historyIndex]['status'] = 'Completed';
          loanHistory[historyIndex]['date'] = DateTime.now()
              .toString()
              .substring(0, 10);
        }

        // Remove from active loans
        activeLoans.removeAt(loanIndex);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loan $loanId has been fully paid.'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        // Update loan details
        double newProgress = 1.0 - (newRemaining / totalAmount);

        activeLoans[loanIndex] = {
          ...loan,
          'remaining': newRemaining,
          'nextDue': newDueString,
          'progress': newProgress,
        };

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Payment successful! Remaining balance: Rp ${_formatCurrency(newRemaining)}',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }
}
