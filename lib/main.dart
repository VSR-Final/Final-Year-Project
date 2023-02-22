import 'package:finalyearproject/pages/account_type.dart';
import 'package:finalyearproject/pages/login_landing.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext contex){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountType(),
    );
  }
}