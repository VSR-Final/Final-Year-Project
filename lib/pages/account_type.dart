import 'package:finalyearproject/components/SignUp.dart';
import 'package:finalyearproject/components/SupportButton.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:flutter/material.dart';

class AccountType extends StatelessWidget{
  const AccountType({super.key});

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

                    Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(child: Text(
                        'Account Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blue,
                        ),),
                      ),
                    ),

                    const SizedBox(height: 100,),

                    Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(child: Text(
                        'Physiotherapist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(child: Text(
                        'Patient',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),


                  ],
                )
            )
        )
    );
  }
}