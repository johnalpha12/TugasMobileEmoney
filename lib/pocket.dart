import 'package:flutter/material.dart';

class Pocket extends StatelessWidget {
  const Pocket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PocketBuild(),
    );
  }
}

class PocketBuild extends StatefulWidget {
  const PocketBuild({super.key});

  static List<String> cards = ['**** **** **** 1234', '**** **** **** 5678'];

  @override
  State<PocketBuild> createState() => _PocketBuildState();
}

class _PocketBuildState extends State<PocketBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pocket',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Kartu',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...PocketBuild.cards.map((card) {
                int index = PocketBuild.cards.indexOf(card) + 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card $index',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          card,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Save your bank cards!',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCardButton(),
                          ),
                        );
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      child: const Text('+ ADD'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCardButton extends StatefulWidget {
  const AddCardButton({super.key});

  @override
  _AddCardButtonState createState() => _AddCardButtonState();
}

class _AddCardButtonState extends State<AddCardButton> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  @override
  void dispose() {
    _cardNumberController.dispose();
    super.dispose();
  }

  void _goToPreview() {
    if (_formKey.currentState!.validate()) {
      String number = _cardNumberController.text.trim();
      String masked = '**** **** **** ${number.substring(number.length - 4)}';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewCardScreen(maskedNumber: masked),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        title: const Text('Add Card', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number (last 12 digits)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the last 12 digits';
                  }
                  if (value.length != 12) {
                    return 'Please enter exactly 12 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _goToPreview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Preview Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewCardScreen extends StatelessWidget {
  final String maskedNumber;

  const PreviewCardScreen({super.key, required this.maskedNumber});

  void _submitCard(BuildContext context) {
    PocketBuild.cards.add(maskedNumber);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Card Preview',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  maskedNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _submitCard(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
