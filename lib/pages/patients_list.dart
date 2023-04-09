import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:finalyearproject/pages/physio_home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:table_calendar/table_calendar.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PatientsList> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  Query dbpatientRef = FirebaseDatabase.instance.ref().child('Users');

  Widget listPatients({required Map patients}) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhysioHomePage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          fixedSize: Size(400, 50),
        ),
        child: Center(
          child: Text(
            capitalize(patients['name']),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: dbpatientRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map patients = snapshot.value as Map;
          patients['key'] = snapshot.key;

          return listPatients(patients: patients);
        },
      ),
    );
    ;
  }
}
