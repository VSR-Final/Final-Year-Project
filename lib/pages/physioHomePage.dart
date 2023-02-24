import 'package:flutter/material.dart';

class PhysioHomePage extends StatefulWidget {
  const PhysioHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PhysioHomePage> {
  String _selectedOption = 'Schedule';

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
      body: Center(
        child: Text('Selected option: $_selectedOption'),
      ),
    );
  }
}
