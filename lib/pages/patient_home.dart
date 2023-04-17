import 'package:finalyearproject/components/excercise_tile.dart';
import 'package:finalyearproject/pages/exercise_detail_page.dart';
import 'package:finalyearproject/pages/patient_schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/components/utils.dart';

import '../models/users.dart';

class PatientHome extends StatefulWidget {
  Users user;

  PatientHome(this.user);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    final CollectionReference patients =
    FirebaseFirestore.instance.collection('patient').doc(widget.user.uid).collection('appointments');
    String name = '';

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[700],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Hello  ${widget.user.name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.deepPurpleAccent[100],
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.grey[200],
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Excercises',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Icon(Icons.more_horiz),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: patients
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                                return Center(child: Text('No appointments found.'));
                              }

                              return ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String name = snapshot.data!.docs[index]['title'];
                                  DateTime date = snapshot.data!.docs[index]['to'].toDate();
                                  return GestureDetector(
                                    onTap: () {
                                      Users patient = Users(
                                        uid: widget.user.uid,
                                        name: widget.user.name,
                                        email: widget.user.email,
                                        phone: widget.user.phone,
                                        dob: widget.user.dob,
                                        userType: widget.user.userType,
                                        status: widget.user.status,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ExerciseDetailPage(widget.user)),
                                      );
                                    },
                                    child: Card(
                                      child: ExcerciseTile(text: name, date: Utils.toDate(date)),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) =>
                                const Divider(),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
