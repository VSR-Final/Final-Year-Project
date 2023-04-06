import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:path_provider/path_provider.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext build){
    return SfCalendar(
      view: CalendarView.month,
      initialDisplayDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
    );
  }
}