import 'dart:convert';
import 'package:finalyearproject/components/button.dart';
import 'package:finalyearproject/components/glassmorphic_container.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'package:finalyearproject/pages/landing_page.dart';
import 'package:finalyearproject/pages/login_page.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalyearproject/models/users.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

FirebaseFirestore collection = FirebaseFirestore.instance;

class _SignUpState extends State<SignUp> {

  @override
  void initState()
  {super.initState();
  getPhysioList();
  }

  
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  XFile? image;
  List<String> items = [];
  String selectedItem = '';
  final databaseRef = FirebaseFirestore.instance;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  void getPhysioList() {
    print('name');
    FirebaseFirestore.instance
        .collection('physiotherapist')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        
        setState(() {
          items.add(doc.get('name'));
        });
      });
    });
  }

  Future<void> getPhysioEmail(String physioName, String patientEmail) async {
    List<Map> searchResult = [];
    //final event = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();
    final data = await databaseRef
        .collection('users')
        .where('name', isEqualTo: physioName)
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

      sendEmail(
          physioName: physioName,
          physioEmail: searchResult[0]['email'],
          patientEmail: patientEmail);
    });
  }

  Future sendEmail({
    required String physioName,
    required String physioEmail,
    required String patientEmail,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://yourapp.page.link',
      link: Uri.parse('https://yourapp.com/accept-patient/$patientEmail'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.finalyearproject',
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.finalyearproject',
      ),
    );

    // Build the short dynamic link
    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    final Uri dynamicUrl = shortLink.shortUrl;

    final serviceId = 'service_ltpchpb';
    final templateId = 'template_wzxed06';
    final userId = 'v_AtU5qYlO8Px4iw0';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http//localhost',
        'Content-Type': 'application/jpon',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': physioName,
          'url': dynamicUrl,
          'to_email': physioEmail,
        }
      }),
    );

    print(response.body);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
    

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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoundedInput(
                            size: size,
                            icon: Icon(
                              Icons.person,
                              color: Colors.deepPurpleAccent.shade400,
                            ),
                            text: 'Name',
                            controller: _nameController,
                            type: TextInputType.text,
                            obscure: false,
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
                          RoundedInput(
                              size: size,
                              icon: Icon(Icons.phone,
                                  color: Colors.deepPurpleAccent.shade400),
                              text: 'Phone Number',
                              controller: _phoneController,
                              type: TextInputType.phone,
                              obscure: false),
                          RoundedInput(
                              size: size,
                              icon: Icon(Icons.calendar_month,
                                  color: Colors.deepPurpleAccent.shade400),
                              text: 'Date of Birth(MM/DD/YYYY)',
                              controller: _dobController,
                              type: TextInputType.datetime,
                              obscure: false),
                          DropdownButton<String>(
                            value: selectedItem.isNotEmpty ? selectedItem : null,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue!;
                              });
                            },
                            items: items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: buttonPrimay,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((value) {
                                  var random = new Random();
                                  var uid = random.nextInt(900000) + 100000;

                                  collection
                                      .collection('users')
                                      .doc(uid.toString())
                                      .set({
                                    'uid': uid.toString(),
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'phone': _phoneController.text,
                                    'dob': _dobController.text,
                                    'userType': 'Patient',
                                    'status': 'Pending'
                                  });
                                  collection
                                      .collection('patient')
                                      .doc(uid.toString())
                                      .set({
                                    'uid': uid.toString(),
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'phone': _phoneController.text,
                                    'dob': _dobController.text,
                                    'userType': 'Patient',
                                    'physiotherapist': selectedItem,
                                  });
                                  getPhysioEmail(
                                      selectedItem, _emailController.text);
                                });
                              }
                            },
                            child: Text(
                              'Sign Up',
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
                                      builder: (context) => Login()));
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
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
