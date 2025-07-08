import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String gender;

  const EditProfile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController(
      text: "Salim6ntng123",
    ); // Password default
    _phoneController = TextEditingController(text: widget.phoneNumber);
    _selectedGender = widget.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar custom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Profile picture
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('asset/foto.png'),
            ),

            const SizedBox(height: 16),
            Text(
              "${_firstNameController.text} ${_lastNameController.text}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Form section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildFormField("nama depan", _firstNameController),
                      const SizedBox(height: 16),
                      buildFormField("nama Belakang", _lastNameController),
                      const SizedBox(height: 16),
                      buildFormField("Email", _emailController),
                      const SizedBox(height: 16),
                      buildFormField(
                        "Sandi",
                        _passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      buildFormField("No Hp", _phoneController),
                      const SizedBox(height: 16),

                      // Jenis Kelamin Radio Button
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("Pria"),
                              value: "Pria",
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("Wanita"),
                              value: "Wanita",
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Confirm button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Kembalikan data yang telah diubah ke halaman profile
                            Navigator.pop(context, {
                              'firstName': _firstNameController.text,
                              'lastName': _lastNameController.text,
                              'phoneNumber': _phoneController.text,
                              'email': _emailController.text,
                              'gender': _selectedGender,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
      ],
    );
  }
}
