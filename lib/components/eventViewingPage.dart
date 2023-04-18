import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/components/EventEditingPage.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:finalyearproject/pages/physio_home.dart';
import 'package:finalyearproject/pages/physiotherapist_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/components/EventProvider.dart';
import 'package:finalyearproject/components/utils.dart';
import 'package:provider/provider.dart';
import 'package:finalyearproject/components/eventViewingPage.dart';
import 'package:finalyearproject/components/event.dart';
import 'package:intl/intl.dart';
import '../models/users.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  final Users user;


  const EventViewingPage({
    Key? key,
    required this.event,
    required this.user,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildViewingActions(context, event),
    ),
    body: ListView(
      padding: EdgeInsets.all(31),
      children: <Widget>[
        buildDateTime(event),
        SizedBox(height: 32,),
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Text(
          'patient: ' + event.name,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20,),
        Text('extra information: ' + event.description,
        style: TextStyle(fontSize: 18),),
        const SizedBox(height: 24,),
      ],
    ),
  );

  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day': 'From', event.from),
      if (!event.isAllDay) buildDate('To', event.to)
      ],
    );
  }

  Widget buildDate(String title, DateTime date){
    String text = Utils.toDate(date) + ' ' + Utils.toTime(date);
    return Column(
      children: [
        Text(text),

      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) => [

    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EventEditingPage(event: event, user: user)),
      ),
    ),
    IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {
      final provider = Provider.of<EventProvider>(context, listen: false);

      FirebaseFirestore.instance.collection("physiotherapist").doc(user.uid).collection('appointments').doc(event.appointmentID).delete();

      provider.deleteEvent(event);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  PhysiotherapistMenu(user)));

    }
    ),
  ];
}


