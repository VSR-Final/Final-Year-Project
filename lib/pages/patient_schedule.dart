import 'package:finalyearproject/components/PatientCalendarWidget.dart';
import 'package:finalyearproject/components/PhysioCalendarWidget.dart';
import 'package:finalyearproject/components/EventEditingPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/users.dart';
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/components/event.dart';
import '../models/users.dart';
import 'package:finalyearproject/components/EventProvider.dart';

class PatientSchedule extends StatefulWidget {
  Users user;
  PatientSchedule(this.user);

  @override
  _PatientScheduleState createState() => _PatientScheduleState();
}

class _PatientScheduleState extends State<PatientSchedule> {


  @override
  void initState(){
    initEvents();
    super.initState();
  }


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
    List<Event> eventsget = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: PatientCalendarWidget(user: widget.user),
    );
  }

  Future<void> initEvents() async{
    final event_provider = Provider.of<EventProvider>(context, listen: false);

    event_provider.deleteAll();

    final data = await FirebaseFirestore.instance
        .collection('patient').doc(widget.user.uid).collection('appointments')
        .get();

    data.docs.forEach((doc) {
       final eventEvent = Event(
        title: doc.get('title'),
         description: doc.get('description'),
         from: doc.get('from').toDate(),
         to: doc.get('to').toDate(),
         isAllDay: doc.get('isAllDay'),
          name: doc.get('physiotherapist_name'),
          nameID: doc.get('physiotherapist_id'),
          exerciseID: doc.get('exerciseID'),
          appointmentID: doc.id,
         isAppointment: doc.get('isAppointment')
       );


        event_provider.addEvent(eventEvent);
    });
  }


}
