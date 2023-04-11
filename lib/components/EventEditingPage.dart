import 'package:finalyearproject/components/event.dart';
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

class _EventEditingPageState extends State<EventEditingPage>{
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  @override
  void initState() {
    super.initState();

    getPatientList();

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
  List<String> uids = [];
  String selectedItem = '';
  String uid = '';
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

        Navigator.of(context).pop();
      } else {

        await FirebaseFirestore.instance.collection('patient').doc(uid).collection('appointments').doc(widget.user.uid).set({
          "title": titleController.text,
          "description": 'description',
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "physiotherapist_name": widget.user.name,
        });

        await FirebaseFirestore.instance.collection('physiotherapist').doc(widget.user.uid).collection('appointments').doc(uid).set({
          "title": titleController.text,
          "description": 'description',
          "from": fromDate,
          "to": toDate,
          "isAllDay": false,
          "patient_name": selectedItem,
        });

      }

      Navigator.of(context).pop();
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


