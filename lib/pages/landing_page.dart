import 'package:finalyearproject/pages/account_type.dart';
import 'package:finalyearproject/pages/logInPage.dart';
import 'package:finalyearproject/pages/login_page.dart';
import 'package:finalyearproject/pages/signUpPage.dart';
import 'package:finalyearproject/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              child: Column(children: [
                SizedBox(height: 10,),
                Container(
                  height: 400,
                  width: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text('Welcome!',
                style: GoogleFonts.roboto(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                )
                ),
                SizedBox(height: 10,),
                Text('Choose an option',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login()));
                  },
                  style: buttonPrimay,

                  child: const Center(child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUp()));
                  },
                  style: buttonPrimay,

                  child: const Center(child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size(200, 40),
                      backgroundColor: Colors.deepPurpleAccent,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50),

                        ),
                      )
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
              ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 