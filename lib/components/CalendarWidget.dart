import 'dart:js';

import 'package:finalyearproject/components/EventProvider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:finalyearproject/components/EventDataSource.dart';
import 'package:provider/src/provider.dart';
import 'package:finalyearproject/components/TaskWidget.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialDisplayDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(context: context, builder: (context) => TaskWidget(),);
      },
    );
  }
}