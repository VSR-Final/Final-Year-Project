import 'package:uuid/uuid.dart';

class Users {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String dob;

  Users({
    String? id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
  }) : id = id ?? Uuid().v4();

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        dob = json['dob'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'phone': phone, 'dob': dob};
}
