import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:finalyearproject/pages/logInPage.dart';
import 'package:finalyearproject/components/SupportButton.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginLanding extends StatelessWidget{
  const LoginLanding({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children:  [
              const SizedBox(height: 50),

              Image(
                image: AssetImage('assets/transparent_logo.png'),
                height: 400,
                width: 400,
              ),
              const SizedBox(height: 20,),
              
              Text('Welcome!',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                    fixedSize: Size(400, 50),

                ),

                child: const Center(child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(400, 50),

                ),

                child: const Center(child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(400, 50),

                ),

                child: const Center(child: Text(
                  'Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
                ),
              ),

            ],
          )
        )
      )
    );
  }
}