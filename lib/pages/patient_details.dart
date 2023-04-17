import 'package:flutter/material.dart';
import '../models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientDetailPage extends StatefulWidget {
  Users patient;
  Users user;
  PatientDetailPage(this.patient, this.user);

  @override
  _PatientDetailPageState createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  bool _isAppointmentExpanded = false;
  bool _isTreatmentPlanExpanded = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference treatmentPlanRef = FirebaseFirestore.instance
        .collection('patients')
        .doc(widget.patient.uid)
        .collection('treatment_plan');
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.patient.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isAppointmentExpanded = !_isAppointmentExpanded;
                      });
                    },
                    child: Text('Appointments'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isTreatmentPlanExpanded = !_isTreatmentPlanExpanded;
                      });
                    },
                    child: Text('Treatment Plan'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (_isAppointmentExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointments:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Add appointment data here
                ],
              ),
            if (_isTreatmentPlanExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Treatment Plan:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Add treatment plan data here
                  StreamBuilder<QuerySnapshot>(
                    stream: treatmentPlanRef.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exercises: ${data['exercises.dart']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Condition: ${data['condition']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Estimated Time: ${data['estimated_time']}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                ],
                              );
                            }).toList(),
                          );
                      }
                    }
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
