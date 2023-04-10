import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/users.dart';

class PendingPatientsPage extends StatefulWidget {
  Users user;

  PendingPatientsPage(this.user);

  @override
  _PendingPatientState createState() => _PendingPatientState();
}

class _PendingPatientState extends State<PendingPatientsPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patient');

    return Scaffold(
      appBar: AppBar(title: Text('Pending Patients')),
      body: StreamBuilder<QuerySnapshot>(
        stream: patients
            .where('physiotherapist', isEqualTo: widget.user.name)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Widget> patientCards =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            return PatientCard(document: document);
          }).toList();

          return ListView(children: patientCards);
        },
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final DocumentSnapshot document;

  PatientCard({required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(document.get('name')),
        subtitle: Text(document.get('email')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () => _approvePatient(context),
            ),
            IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: () => _rejectPatient(context),
            ),
          ],
        ),
      ),
    );
  }

  void _approvePatient(BuildContext context) async {
    // Update the patient's status to "accepted"
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patient');
    await patients.doc(document.id).update({'status': 'Accepted'});

    // Show a snackbar message
    final snackbar = SnackBar(
      content: Text('${document.get('name')} approved.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _rejectPatient(BuildContext context) async {
    // Update the patient's status to "rejected"
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patient');
    await patients.doc(document.id).update({'status': 'Rejected'});

    // Show a snackbar message
    final snackbar = SnackBar(
      content: Text('${document.get('name')} rejected.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
