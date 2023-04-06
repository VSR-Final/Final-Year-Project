import 'package:finalyearproject/components/SupportButton.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/pages/physiosignup.dart';
import 'package:finalyearproject/pages/physiotherapist_signUpPage.dart';
import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:finalyearproject/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
                child: Container(
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
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 400,
                  width: 400,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      'Account Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  style: buttonPrimay,
                  child: const Center(
                    child: Text(
                      'Patient',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhysioSignUp()));
                  },
                  style: buttonPrimay,
                  child: const Center(
                    child: Text(
                      'Physiotherapist',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ))));
  }
}
