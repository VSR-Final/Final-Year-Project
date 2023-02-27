import 'package:finalyearproject/pages/account_type.dart';
import 'package:finalyearproject/pages/landing_page.dart';
import 'package:finalyearproject/pages/login_landing.dart';
import 'package:finalyearproject/pages/patientHomePage.dart';
import 'package:finalyearproject/pages/physioHomePage.dart';
import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:finalyearproject/pages/logInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
