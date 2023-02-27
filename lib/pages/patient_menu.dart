import 'package:finalyearproject/components/excercise_tile.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:finalyearproject/pages/patient_home.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientMenu extends StatefulWidget {
  const PatientMenu({Key? key}) : super(key: key);

  @override
  State<PatientMenu> createState() => _PatientMenuState();
}

class _PatientMenuState extends State<PatientMenu> {
  List pages = [PatientHome(), PatientSchedule()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[700],
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
      ),
    );
  }
}