import 'package:finalyearproject/pages/patients_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class PhysioHomePage extends StatefulWidget {
  const PhysioHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PhysioHomePage> {
  String _selectedOption = 'Schedule';
  Query dbpatientRef = FirebaseDatabase.instance.ref().child('Users');


  @override
  Widget build(BuildContext context) {
    var container;
    if (_selectedOption == "Patients"){
        container = PatientsList();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PhysioAssistant'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Schedule'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Schedule';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Patients'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Patients';

                });
                Navigator.pop(context);

              },
            ),
            ListTile(
              title: Text('Chats'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Chats';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white54,
          centerTitle: true,
          title: Text(_selectedOption, style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: container,
        ),
      ),
    );
  }
}
