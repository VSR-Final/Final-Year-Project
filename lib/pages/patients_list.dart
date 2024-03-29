import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/pages/patient_details.dart';

import '../models/users.dart';

class PatientListPage extends StatefulWidget {
  Users user;
  PatientListPage(this.user);

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('patient');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: patients
            .where('physiotherapist', isEqualTo: widget.user.name)
            .where('status', isEqualTo: 'Accepted')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No patients found.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              String name = snapshot.data!.docs[index]['name'];
              return GestureDetector(
                onTap: () {
                  Users patient = Users(
                    uid: snapshot.data!.docs[index]['uid'],
                    name: snapshot.data!.docs[index]['name'],
                    email: snapshot.data!.docs[index]['email'],
                    phone: snapshot.data!.docs[index]['phone'],
                    dob: snapshot.data!.docs[index]['dob'],
                    userType: snapshot.data!.docs[index]['userType'],
                    status: snapshot.data!.docs[index]['status'],
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PatientDetailPage(patient, widget.user)),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(capitalize(name)),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
    );
  }
}
