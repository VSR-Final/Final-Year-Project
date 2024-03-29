import 'package:finalyearproject/components/excercise_tile.dart';
import 'package:finalyearproject/pages/physio_schedule.dart';
import 'package:finalyearproject/pages/pending_users.dart';
import 'package:finalyearproject/pages/physio_home.dart';
import 'package:finalyearproject/pages/physio_search_user.dart';
import 'package:finalyearproject/pages/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/patients_list.dart';
import 'package:intl/intl.dart';

import '../models/users.dart';

class PhysiotherapistMenu extends StatefulWidget {
  final Users user;
  const PhysiotherapistMenu(this.user);

  @override
  State<PhysiotherapistMenu> createState() => _PhysiotherapistMenuState();
}

class _PhysiotherapistMenuState extends State<PhysiotherapistMenu> {
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      PhysioHomePage(widget.user),
      PatientListPage(widget.user),
      uploadPage(widget.user),
      PendingPatientsPage(widget.user),
      PhysioSearchScreen(widget.user)
    ];
  }

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[700],
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.deepPurpleAccent,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
      ),
    );
  }
}
