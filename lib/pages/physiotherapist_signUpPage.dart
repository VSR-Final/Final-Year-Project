import 'dart:convert';
import 'dart:io';

import 'package:finalyearproject/licenseStorage.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:finalyearproject/pages/physio_home.dart';
import 'package:finalyearproject/pages/physiotherapist_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:finalyearproject/models/users.dart';

class PhysioSignUpPage extends StatefulWidget {
  @override
  _PhysioSignUpPageState createState() => _PhysioSignUpPageState();
}

FirebaseFirestore collection = FirebaseFirestore.instance;

class _PhysioSignUpPageState extends State<PhysioSignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? path;
  String? fileName;

  Future<void> _pickImage() async {
    final LicenseStorage storage = LicenseStorage();
    final pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected.'),
        ), // SnackBar
      );

      return null;
    }

    setState(() {
      path = pickedFile.files.single.path!;
      fileName = pickedFile.files.single.name;
    });

    storage.uploadFile(path!, fileName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth (MM/DD/YYYY)',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Submit Physiotherapist License'),
                ),
                // if (image != null) ...[
                //   SizedBox(height: 16.0),
                //   Image.file(
                //     File(image!.path),
                //     height: 200.0,
                //     width: 200.0,
                //   ),
                // ],
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(400, 50),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) {
                        var random = new Random();
                        var uid = random.nextInt(900000) + 100000;

                        Users user1 = Users(
                            uid: uid.toString(),
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            dob: _dobController.text,
                            userType: 'Physiotherapist',
                            license: fileName!,
                            status: 'Pending');
                        collection.collection('users').doc(uid.toString()).set({
                          'uid': uid.toString(),
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'dob': _dobController.text,
                          'userType': 'Physiotherapist',
                          'license': fileName!,
                          'status': 'Pending',
                        });
                        collection
                            .collection('physiotherapist')
                            .doc(uid.toString())
                            .set({
                          'uid': uid.toString(),
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'dob': _dobController.text,
                          'userType': 'Physiotherapist',
                          'license': fileName!,
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PhysiotherapistMenu(user1)));
                      });
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
