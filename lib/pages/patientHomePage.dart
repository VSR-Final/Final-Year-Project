import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomePage> {
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
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              title: Text('Schedule'),
              onTap: () {
                // TODO: Handle menu item selection
              },
            ),
            ListTile(
              title: Text('Patients'),
              onTap: () {
                // TODO: Handle menu item selection
              },
            ),
            ListTile(
              title: Text('Chats'),
              onTap: () {
                // TODO: Handle menu item selection
              },
            ),
          ],
        ),
      ),
      body: TableCalendar(
        locale: "en_US",
        rowHeight: 43,
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, today),
        focusedDay: today,
        firstDay: DateTime.utc(2018, 10, 16),
        lastDay: DateTime.utc(2038, 3, 14),
        onDaySelected: _onDaySelected,
      ),
    );
  }
}
