import 'package:finalyearproject/components/EventProvider.dart';
import 'package:finalyearproject/pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'dynamicLinkListener.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initDynamicLinks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: LandingPage()));
  }
}
