import 'dart:math';

import 'package:finalyearproject/components/event.dart';
import 'package:finalyearproject/components/exercises.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'package:finalyearproject/pages/patient_menu.dart';
import 'package:finalyearproject/pages/physio_schedule.dart';
import 'package:finalyearproject/pages/physio_home.dart';
import 'package:finalyearproject/pages/physiotherapist_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:finalyearproject/components/utils.dart';
import 'package:provider/src/provider.dart';
import 'package:finalyearproject/components/EventProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users.dart';


class EventEditingPage extends StatefulWidget {
  final Event? event;
  final Users user;

  const EventEditingPage({
    Key? key,
    this.event,
    required this.user,
}) : super (key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

enum YesNo { appointment, exercise }

class _EventEditingPageState extends State<EventEditingPage>{
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  YesNo? _character = YesNo.exercise;

  @override
  void initState() {
    super.initState();

    getPatientList();
    getExerciseList();

    if (widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
    }
}

  List<String> items = [];
  List<String> items2 = [];
  List<String> uids = [];
  List<String> uids2 = [];
  String selectedItem = '';
  String selectedItem2 = '';
  String uid = '';
  String uid2 = 'none';
  final databaseRef = FirebaseFirestore.instance;

  void getPatientList() {
    FirebaseFirestore.instance
        .collection('patient').where('physiotherapist', isEqualTo: widget.user.name)
        .where('status', isEqualTo: 'Accepted')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          items.add(doc.get('name'));
          uids.add(doc.get('uid'));
        });
      });
    });
  }

  void getExerciseList(){
    FirebaseFirestore.instance
        .collection('exercises')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          items2.add(doc.get('name'));
          uids2.add(doc.id);
        });
      });
    });
  }

@override
  void dispose(){
    titleController.dispose();
    super.dispose();
}
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
            SizedBox(height: 12),
            buildDateTimePickers(),
            SizedBox(height: 15,),

            Text('Patient'),

            SizedBox(height: 10,),

            DropdownButton<String>(
              value:
              selectedItem.isNotEmpty ? selectedItem : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue!;
                  int index = items.indexOf(selectedItem);
                  uid = uids[index];
                });
              },
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(height: 20,),


            if (_character == YesNo.exercise)...[
              Text('Exercise'),
              SizedBox(height: 10,),
              DropdownButton<String>(
                value:
                selectedItem2.isNotEmpty ? selectedItem2 : null,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem2 = newValue!;
                    int exerciseIndex = items2.indexOf(selectedItem2);
                    uid2 = uids2[exerciseIndex];
                  });
                },
                items: items2.map((String item2) {
                  return DropdownMenuItem(
                    value: item2,
                    child: Text(item2),
                  );
                }).toList(),
              ),
      ],
            SizedBox(height: 20,),
        InputContainer(
          child: TextFormField(
            controller: descriptionController,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'extra information',
                border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                descriptionController == 'none';
              }
              return null;
            },
          ),
        ),
            SizedBox(height: 20,),
            Text('Is this an appointment or schedueled exercise'),
            SizedBox(height: 15,),
            ListTile(
              title: const Text('Exercise'),
              leading: Radio<YesNo>(
                value: YesNo.exercise,
                groupValue: _character,
                onChanged: (YesNo? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Appointment'),
              leading: Radio<YesNo>(
                value: YesNo.appointment,
                groupValue: _character,
                onChanged: (YesNo? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );

  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent
        ),
        onPressed: saveForm,icon: Icon(Icons.done), label: Text('Save'))
  ];

  Widget buildTitle() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Event Title',
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: (title) =>
        title != null && title.isEmpty ? 'Title can not be empty' : null,
    controller: titleController,
  );

  Widget buildDateTimePickers() => Column(
    children: [
      buildFrom(),
      buildTo(),
    ],
  );

  Widget buildFrom() => buildHeader(
    header: "From",
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: buildDropdownField(
          text: Utils.toDate(fromDate),
          onClicked: () => pickFromDateTime(pickDate: true),
        ),),
        Expanded(child:
        buildDropdownField(
          text: Utils.toTime(fromDate),
          onClicked: () => pickFromDateTime(pickDate: false),))
      ],
    ),
  );

  Widget buildTo() => buildHeader(header: "To",
    child: Row(
    children: [
      Expanded(
        flex: 2,
        child: buildDropdownField(
          text: Utils.toDate(toDate),
          onClicked: () => pickToDateTime(pickDate: true),
        ),),
      Expanded(child:
      buildDropdownField(
        text: Utils.toTime(toDate),
        onClicked: () => pickToDateTime(pickDate: false),))
    ],
  ),);

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
    //required VoidCallBack onClicked,
}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
     onTap: onClicked,
     //   onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: TextStyle(fontWeight: FontWeight.bold),),
          child,
        ],
      );

  Future saveForm() async{
    final isValid = _formKey.currentState!.validate();

    if (isValid){


      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        //editing
        await FirebaseFirestore.instance.collection('patient').doc(uid).collection('appointments').doc(widget.event!.appointmentID).set({
          "title": titleController.text,
          "physiotherapist_id": widget.user.uid,
          "description": descriptionController.text,
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "physiotherapist_name": widget.user.name,
          "exerciseID": uid2,
          "isAppointment": _character.toString() == 'exercise' ? false : true,
        });

        await FirebaseFirestore.instance.collection('physiotherapist').doc(widget.user.uid).collection('appointments').doc(widget.event!.appointmentID).set({
          "title": titleController.text,
          "patient_id": uid,
          "description": descriptionController.text,
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "patient_name": selectedItem,
          "exerciseID": uid2,
          "isAppointment": _character.toString() == 'exercise' ? false : true,
        });


        Navigator.of(context).pop();
      } else {
        // late Exercises exercise;
        // final data = await FirebaseFirestore.instance
        //     .collection('exercises.dart').where('uid', isEqualTo: uid2).get();
        //
        // data.docs.forEach((doc) {
        //   final eventExercise = Exercises(
        //       exerciseID: doc.get('exerciseID'),
        //       downloadLink: doc.get('downloadID'),
        //       fileName: doc.get('fileName').toDate(),
        //       name: doc.get('name'),
        //       physiotherapistID: doc.get('physiotherapistID'));
        //
        //   exercise = eventExercise;
        //
        // });

        var random = new Random();
        var appointment_uid = 'AP' + (random.nextInt(900000) + 100000).toString();

        await FirebaseFirestore.instance.collection('patient').doc(uid).collection('appointments').doc(appointment_uid).set({
          "title": titleController.text,
          "physiotherapist_id": widget.user.uid,
          "description": descriptionController.text,
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "physiotherapist_name": widget.user.name,
          "exerciseID": uid2,
          "isAppointment": _character.toString() == 'exercise' ? false : true,
        });

        await FirebaseFirestore.instance.collection('physiotherapist').doc(widget.user.uid).collection('appointments').doc(appointment_uid).set({
          "title": titleController.text,
          "patient_id": uid,
          "description": descriptionController.text,
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "patient_name": selectedItem,
          "exerciseID": uid2,
          "isAppointment": _character.toString() == 'exercise' ? false : true,
        });

      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => PhysiotherapistMenu(widget.user)));
    }
  }

  Future pickFromDateTime({required bool pickDate}) async{
      final date = await pickDateTime(fromDate, pickDate: pickDate);

      if (date == null) return;

      if(date.isAfter(toDate)){
        toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
      }

      setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async{
    final date = await pickDateTime(toDate, pickDate: pickDate, firstDate: pickDate ? fromDate : null);

    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime (
    DateTime initialDate, {
      required bool pickDate,
      DateTime? firstDate,
  }) async {
      if (pickDate) {
        final date = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate ?? DateTime(2015, 8), lastDate: DateTime(2101));

        if (date == null) return null;

        final time = Duration(hours: initialDate.hour, minutes: initialDate.minute );

        return date.add(time);
  } else {
        final timeOfDay = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

        if (timeOfDay == null) return null;

        final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
        final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

        return date.add(time);
      }
  }



}


