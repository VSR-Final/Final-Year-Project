import 'package:uuid/uuid.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String dob;

  Users({
    String? uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
  }) : uid = uid ?? Uuid().v4();

  Users.fromJson(Map<String, dynamic> json)
      : uid = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        dob = json['dob'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'phone': phone, 'dob': dob};
}
