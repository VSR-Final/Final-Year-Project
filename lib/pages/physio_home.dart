import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:finalyearproject/pages/patients_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/users.dart';

class PhysioHomePage extends StatefulWidget {
  Users user;
  PhysioHomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PhysioHomePage> {
  String _selectedOption = 'Schedule';
  Query dbpatientRef = FirebaseDatabase.instance.ref().child('Users');
  DateTime today = DateTime.now();

  Map<DateTime, List<dynamic>> _events = {
    DateTime(2022, 3, 1): ['Event A', 'Event B'],
    DateTime(2022, 3, 5): ['Event C'],
    DateTime(2022, 3, 13): ['Event D', 'Event E'],
  };

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (_selectedOption == "Patients") {
      container = PatientListPage(widget.user);
    }
    if (_selectedOption == "Schedule") {
      container = PatientSchedule(widget.user);
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
      // body: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Colors.white54,
      //     centerTitle: true,
      //     title: Text(
      //       _selectedOption,
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      body: Center(
        child: container,
      ),
      //),
    );
  }
}
