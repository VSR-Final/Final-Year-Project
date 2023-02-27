import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:finalyearproject/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

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
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PatientMenu()));
                            });
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
