import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_project/modals/phone_contact_model.dart';

class AddContactView extends StatefulWidget {
  final Function(PhoneContactModel) onSaveContact; // Callback to pass data

  const AddContactView({super.key, required this.onSaveContact});

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _generateRandomId() {
    final now = DateTime.now();
    final random = Random().nextInt(1000); // Add some randomness
    return '${now.millisecondsSinceEpoch}_$random';
  }

  void _saveContact() {
    final id = _generateRandomId();
    final name = _nameController.text;
    final phoneNumber = _phoneNumberController.text;
    final email = _emailController.text;
    final address = _addressController.text;
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (name.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Tên và số điện thoại không được để trống!")),
      );
      return;
    }
    if (!phoneRegex.hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Số điện thoại không hợp lệ!")),
      );
      return;
    }

    final newContact = PhoneContactModel(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
    );

    widget.onSaveContact(newContact); // Call the callback function

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã lưu liên hệ: $name")),
    );

    // Clear the fields after saving
    _nameController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    _addressController.clear();

    Navigator.pop(context); // Go back to the previous screen (HomeView)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Liên Hệ'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Tên",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Số Điện Thoại",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Địa Chỉ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _saveContact,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Lưu",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
}
