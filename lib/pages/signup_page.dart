import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'package:finalyearproject/pages/login_page.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalyearproject/models/users.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

 FirebaseFirestore collection = FirebaseFirestore.instance;

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  XFile? image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage('assets/background_t.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomGlassmorphicContainer(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    height: defaultLoginSize,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoundedInput(
                            size: size,
                            icon: Icon(
                              Icons.person,
                              color: Colors.deepPurpleAccent.shade400,
                            ),
                            text: 'Name',
                            controller: _nameController,
                            type: TextInputType.text,
                            obscure: false,
                          ),
                          RoundedInput(
                            size: size,
                            icon: Icon(Icons.email,
                                color: Colors.deepPurpleAccent.shade400),
                            text: 'Email',
                            controller: _emailController,
                            type: TextInputType.emailAddress,
                            obscure: false,
                          ),
                          RoundedInput(
                            size: size,
                            icon: Icon(Icons.password,
                                color: Colors.deepPurpleAccent.shade400),
                            text: 'Password',
                            controller: _passwordController,
                            type: TextInputType.text,
                            obscure: true,
                          ),
                          RoundedInput(
                              size: size,
                              icon: Icon(Icons.phone,
                                  color: Colors.deepPurpleAccent.shade400),
                              text: 'Phone Number',
                              controller: _phoneController,
                              type: TextInputType.phone,
                              obscure: false),
                          RoundedInput(
                              size: size,
                              icon: Icon(Icons.calendar_month,
                                  color: Colors.deepPurpleAccent.shade400),
                              text: 'Date of Birth(MM/DD/YYYY)',
                              controller: _dobController,
                              type: TextInputType.datetime,
                              obscure: false),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: buttonPrimay,
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
                                  );
                                  collection.collection('users').doc(uid.toString()).set({
                                    'uid': uid.toString(),
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'phone': _phoneController.text,
                                    'dob': _dobController.text,
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PatientMenu(user1)));
                                });
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            style: ElevatedButton.styleFrom(
                                maximumSize: Size(200, 40),
                                backgroundColor: Colors.deepPurpleAccent,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                )),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
