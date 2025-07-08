import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  // Add filter state
  String _selectedFilter = 'All Messages';
  final List<String> _filterOptions = [
    'All Messages',
    'Less than 10 days',
    'Less than 20 days',
    'Less than 30 days',
    'More than 30 days',
  ];

  // Updated with more messages and actual dates for filtering
  final List<Message> _allMessages = [
    // Less than 10 days
    Message(
      sender: 'CashEase Team',
      subject: 'Welcome to CashEase!',
      content: 'Thank you for choosing CashEase for your financial needs.',
      time: 'Today',
      date: DateTime.now(),
      isRead: false,
    ),
    Message(
      sender: 'CashEase Support',
      subject: 'Transaction Confirmation',
      content:
          'Your recent transfer of Rp. 500.000 to Jane Doe was successful.',
      time: 'Yesterday',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    Message(
      sender: 'Promotions',
      subject: 'Special Offer Just For You!',
      content: 'Get 5% cashback on all transactions this weekend.',
      time: '3 days ago',
      date: DateTime.now().subtract(const Duration(days: 3)),
      isRead: false,
    ),
    Message(
      sender: 'CashEase Security',
      subject: 'Security Alert',
      content: 'New login detected from your device.',
      time: '6 days ago',
      date: DateTime.now().subtract(const Duration(days: 6)),
      isRead: true,
    ),

    // Less than 20 days
    Message(
      sender: 'CashEase Rewards',
      subject: 'You\'ve earned points!',
      content:
          'You\'ve earned 500 reward points from your recent transactions.',
      time: '12 days ago',
      date: DateTime.now().subtract(const Duration(days: 12)),
      isRead: true,
    ),
    Message(
      sender: 'Partner Offers',
      subject: 'Exclusive Dining Discount',
      content:
          'Enjoy 20% off at selected restaurants when you pay with CashEase.',
      time: '15 days ago',
      date: DateTime.now().subtract(const Duration(days: 15)),
      isRead: false,
    ),
    Message(
      sender: 'CashEase Team',
      subject: 'App Update Available',
      content: 'Update to the latest version of CashEase for new features.',
      time: '18 days ago',
      date: DateTime.now().subtract(const Duration(days: 18)),
      isRead: true,
    ),

    // Less than 30 days
    Message(
      sender: 'CashEase Support',
      subject: 'Profile Verification',
      content: 'Your profile verification has been completed successfully.',
      time: '22 days ago',
      date: DateTime.now().subtract(const Duration(days: 22)),
      isRead: true,
    ),
    Message(
      sender: 'CashEase Security',
      subject: 'Security Tips',
      content: 'Keep your account secure by updating your password regularly.',
      time: '26 days ago',
      date: DateTime.now().subtract(const Duration(days: 26)),
      isRead: false,
    ),
    Message(
      sender: 'CashEase Team',
      subject: 'New Feature Announcement',
      content: 'We\'ve added new payment options for your convenience.',
      time: '29 days ago',
      date: DateTime.now().subtract(const Duration(days: 29)),
      isRead: true,
    ),

    // More than 30 days
    Message(
      sender: 'CashEase Team',
      subject: 'Monthly Statement',
      content: 'Your April statement is now available for review.',
      time: '35 days ago',
      date: DateTime.now().subtract(const Duration(days: 35)),
      isRead: true,
    ),
    Message(
      sender: 'Promotions',
      subject: 'Limited Time Offer',
      content: 'Transfer funds with zero fees for the next week!',
      time: '42 days ago',
      date: DateTime.now().subtract(const Duration(days: 42)),
      isRead: true,
    ),
    Message(
      sender: 'CashEase Support',
      subject: 'Account Enhancement',
      content: 'We\'ve improved your account security features.',
      time: '60 days ago',
      date: DateTime.now().subtract(const Duration(days: 60)),
      isRead: true,
    ),
  ];

  // Filtered messages list
  late List<Message> _messages;

  @override
  void initState() {
    super.initState();
    // Initialize messages with all messages
    _messages = _allMessages;
  }

  // Filter messages based on selected option
  void _filterMessages(String filter) {
    setState(() {
      _selectedFilter = filter;

      if (filter == 'All Messages') {
        _messages = _allMessages;
      } else if (filter == 'Less than 10 days') {
        _messages =
            _allMessages
                .where((msg) => DateTime.now().difference(msg.date).inDays < 10)
                .toList();
      } else if (filter == 'Less than 20 days') {
        _messages =
            _allMessages
                .where((msg) => DateTime.now().difference(msg.date).inDays < 20)
                .toList();
      } else if (filter == 'Less than 30 days') {
        _messages =
            _allMessages
                .where((msg) => DateTime.now().difference(msg.date).inDays < 30)
                .toList();
      } else if (filter == 'More than 30 days') {
        _messages =
            _allMessages
                .where(
                  (msg) => DateTime.now().difference(msg.date).inDays >= 30,
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Dropdown filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Text(
                  'Filter by: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.deepPurple,
                        ),
                        items:
                            _filterOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _filterMessages(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List of messages or empty state
          Expanded(
            child:
                _messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageTile(_messages[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Messages',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any messages yet',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(Message message) {
    return Container(
      decoration: BoxDecoration(
        color: message.isRead ? Colors.white : Colors.blue[50],
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            message.sender[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          message.subject,
          style: TextStyle(
            fontWeight: message.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              message.sender,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              message.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            if (!message.isRead)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        onTap: () {
          setState(() {
            message.isRead = true;
          });
          // Navigate to message detail page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageDetailPage(message: message),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  final String sender;
  final String subject;
  final String content;
  final String time;
  final DateTime date; // Added date for filtering
  bool isRead;

  Message({
    required this.sender,
    required this.subject,
    required this.content,
    required this.time,
    required this.date,
    required this.isRead,
  });
}

class MessageDetailPage extends StatelessWidget {
  final Message message;

  const MessageDetailPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Message Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {
              // Show delete confirmation
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Delete Message'),
                      content: const Text(
                        'Are you sure you want to delete this message?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Go back to inbox
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.subject,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    message.sender[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'To: me',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Text(message.time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Dear User,\n\n${message.content}\n\nThank you for using CashEase. If you have any questions, please don\'t hesitate to contact our customer support team.\n\nBest regards,\nThe CashEase Team',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
