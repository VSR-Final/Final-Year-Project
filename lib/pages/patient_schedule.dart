import 'package:finalyearproject/components/CalendarWidget.dart';
import 'package:finalyearproject/components/EventEditingPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientSchedule extends StatefulWidget {
  const PatientSchedule({super.key});

  @override
  _PatientScheduleState createState() => _PatientScheduleState();
}

class _PatientScheduleState extends State<PatientSchedule> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventEditingPage())
        ),
      ),
    );
  }
}
