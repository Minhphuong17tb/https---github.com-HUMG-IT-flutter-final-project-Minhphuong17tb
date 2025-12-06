import 'package:flutter/material.dart';
import 'package:flutter_project/modals/phone_contact_model.dart';

class EditContactView extends StatefulWidget {
  final PhoneContactModel contact;
  final Function(PhoneContactModel) onUpdateContact;

  const EditContactView(
      {super.key, required this.contact, required this.onUpdateContact});

  @override
  State<EditContactView> createState() => _EditContactViewState();
}

class _EditContactViewState extends State<EditContactView> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneNumberController =
        TextEditingController(text: widget.contact.phoneNumber);
    _emailController = TextEditingController(text: widget.contact.email);
    _addressController = TextEditingController(text: widget.contact.address);
  }

  void _updateContact() {
    final updatedName = _nameController.text;
    final updatedPhoneNumber = _phoneNumberController.text;
    final updatedEmail = _emailController.text;
    final updatedAddress = _addressController.text;

    if (updatedName.isEmpty || updatedPhoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Tên và số điện thoại không được để trống!")),
      );
      return;
    }

    // Update the contact model
    widget.contact.name = updatedName;
    widget.contact.phoneNumber = updatedPhoneNumber;
    widget.contact.email = updatedEmail;
    widget.contact.address = updatedAddress;

    widget.onUpdateContact(widget.contact); // Pass updated contact to callback

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cập nhật thành công!")),
    );

    Navigator.pop(context); // Close the edit page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa Liên Hệ'),
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
                key: const Key('update_contact_button'), // Add a unique key
                onTap: _updateContact,
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
                        "Cập Nhật",
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
