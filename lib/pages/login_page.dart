import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:finalyearproject/pages/physiotherapist_menu.dart';
import 'package:finalyearproject/pages/signup_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/physio_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/users.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final databaseRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    Future<Users?> getUser(String email) async {
      List<Map> searchResult = [];
      //final event = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();
      final data = await databaseRef
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        if (value.docs.length < 1) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No User Found")));
          return null;
        }

        value.docs.forEach((user) {
          searchResult.add(user.data());
        });

        Users user1 = Users(
          uid: searchResult[0]['uid'],
          name: searchResult[0]['name'],
          email: searchResult[0]['email'],
          phone: searchResult[0]['phone'],
          dob: searchResult[0]['dob'],
          userType: searchResult[0]['userType'],
          status: searchResult[0]['status'],
        );
        if (searchResult[0]['status'] == 'Pending' && searchResult[0]['userType'] == 'Patient') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Account still pending")));
          return null;
        } else {
          if (searchResult[0]['userType'] == 'Patient') {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientMenu(user1)));
            });
          } else {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                .then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhysiotherapistMenu(user1)));
            });
          }
        }
      });
    }

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Image(
                          image: AssetImage('assets/logo.png'),
                          width: 300,
                          height: 300,
                        ),
                        SizedBox(
                          height: 40,
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
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: buttonPrimay,
                          onPressed: () {

                            getUser(_emailController.text);
                          },
                          child: Text(
                            'Login',
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
                                    builder: (context) => SignUp()));
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
                              'SignUp',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to forgot password page
                          },
                          child: Text(
                            'Forgot password',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
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
