import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomePage> {
  String _selectedOption = 'Schedule';
  DateTime _selectedDate = DateTime.now();
  DateTime _lastDay =
      DateTime.utc(2023, 12, 31); // define the last day of the calendar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Schedule'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Schedule';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Patients'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Patients';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Chats'),
              onTap: () {
                setState(() {
                  _selectedOption = 'Chats';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _selectedOption == 'Schedule'
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime.utc(2021),
                  lastDay: _lastDay,
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (date, events) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  availableCalendarFormats: {
                    CalendarFormat.month: 'Month',
                  },
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(fontSize: 20),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  onPageChanged: (focusedDay) {
                    if (isSameDay(focusedDay, _lastDay) ||
                        focusedDay.isBefore(_lastDay)) {
                      setState(() {
                        _selectedDate = focusedDay;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('This is the schedule.'),
                    ),
                  ),
                ),
              ],
            )
          : _selectedOption == 'Patients'
              ? Center(
                  child: Text('This is the patients page.'),
                )
              : Center(
                  child: Text('This is the chats page.'),
                ),
    );
  }
}
