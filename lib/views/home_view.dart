import 'package:flutter_project/views/update_contact_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/views/add_contact_view.dart';
import 'package:flutter_project/modals/phone_contact_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<PhoneContactModel> contacts = [
    PhoneContactModel(
      id: "1",
      name: "Nguyễn Văn A",
      phoneNumber: "0123456789",
      email: "nguyen@example.com",
      address: "Hà Nội",
    ),
    PhoneContactModel(
      id: "2",
      name: "Trần Thị B",
      phoneNumber: "0987654321",
      email: "tran@example.com",
      address: "Hồ Chí Minh",
    ),
    PhoneContactModel(
      id: "3",
      name: "Lê Văn C",
      phoneNumber: "0912345678",
      email: "le@example.com",
      address: "Đà Nẵng",
    ),
  ];

  void _addContact(PhoneContactModel contact) {
    setState(() {
      contacts.add(contact);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${contact.name} đã được thêm.")),
    );
  }

  void _updateContact(PhoneContactModel updatedContact) {
    setState(() {
      int index =
          contacts.indexWhere((contact) => contact.id == updatedContact.id);
      if (index != -1) {
        contacts[index] = updatedContact;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${updatedContact.name} đã được cập nhật.")),
    );
  }

  void _showContactDetails(BuildContext context, PhoneContactModel contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepOrange, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "${contact.name}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Số điện thoại: ${contact.phoneNumber}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 5),
                if (contact.email.isNotEmpty)
                  Text(
                    "Email: ${contact.email}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                const SizedBox(height: 5),
                if (contact.address.isNotEmpty)
                  Text(
                    "Địa chỉ: ${contact.address}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Căn đều khoảng cách giữa các nút
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContactView(
                                contact: contact,
                                onUpdateContact: _updateContact,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: const Text("Sửa",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Khoảng cách giữa các nút
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _confirmDelete(context, contact);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Căn giữa nội dung
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Xóa",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10), // Khoảng cách giữa các nút
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade700,
                        ),
                        child: const Text("Đóng",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, PhoneContactModel contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xóa liên hệ'),
          content: Text('Bạn có chắc chắn muốn xóa ${contact.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.remove(contact);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${contact.name} đã bị xóa.")),
                );
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Danh Bạ')),
        backgroundColor: Colors.deepOrange,
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text(
                "Danh bạ trống.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 25,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showContactDetails(context, contact);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddContactView(onSaveContact: _addContact);
          }));
        },
        backgroundColor: Colors.deepOrange,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Thêm liên hệ",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
