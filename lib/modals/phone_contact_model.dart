import 'dart:convert';

class PhoneContactModel {
  String id;
  String name;
  String phoneNumber;
  String email;
  String address;
  PhoneContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  PhoneContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? address,
  }) {
    return PhoneContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
    };
  }

  factory PhoneContactModel.fromMap(Map<String, dynamic> map) {
    return PhoneContactModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneContactModel.fromJson(String source) =>
      PhoneContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PhoneContactModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneContactModel &&
        other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode;
  }
}
