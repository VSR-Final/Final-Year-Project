import 'package:finalyearproject/components/EventProvider.dart';
import 'package:finalyearproject/components/PatientTaskWidget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:finalyearproject/components/EventDataSource.dart';
import 'package:provider/src/provider.dart';
import 'package:finalyearproject/components/PhysioTaskWidget.dart';
import '../models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/components/event.dart';
import 'package:finalyearproject/components/EventProvider.dart';


class PatientCalendarWidget extends StatelessWidget {
  final Users user;

  const PatientCalendarWidget({
    Key? key,
    required this.user,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialDisplayDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => PatientTaskWidget(user: user),
        );
      },
    );
  }
}
