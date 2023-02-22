import 'package:finalyearproject/components/SignUp.dart';
import 'package:finalyearproject/components/SupportButton.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:flutter/material.dart';

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

              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 50,),
              
              Text('Welcome!',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 200,),

              SignUp(),
              const SizedBox(height: 20,),
              Button(),
              const SizedBox(height: 20,),
              Support(),

            ],
          )
        )
      )
    );
  }
}