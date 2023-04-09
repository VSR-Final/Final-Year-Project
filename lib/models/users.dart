import 'package:uuid/uuid.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String userType;
  final String license;

  Users({
    String? uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.userType,
    this.license = 'Not Required for Patient',
  }) : uid = uid ?? Uuid().v4();

  Users.fromJson(Map<String, dynamic> json)
      : uid = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        dob = json['dob'],
        userType = json['userType'],
        license = json['license'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'dob': dob,
        'userType': userType,
        'license': license,
      };
}
