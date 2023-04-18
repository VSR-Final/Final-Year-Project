import 'package:finalyearproject/components/EventProvider.dart';
import 'package:finalyearproject/pages/exercise_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:finalyearproject/components/EventDataSource.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:finalyearproject/components/eventViewingPage.dart';
import '../models/users.dart';

class PatientTaskWidget extends StatefulWidget {
  final Users user;

  const PatientTaskWidget({
    Key? key,
    required this.user,
  }) : super (key: key);

  @override
  _PatientTaskWidgetState createState() => _PatientTaskWidgetState();
}

class _PatientTaskWidgetState extends State<PatientTaskWidget> {
  @override
  Widget build(BuildContext context){
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty){
      return Center(
        child: Text(
          'No Events Found!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.black)
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        appointmentBuilder: appointmentBuilder,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExerciseDetailPage(widget.user, event),
          ));
        },
      )
    );
  }

  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details,
      ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}