import 'package:flutter/material.dart';
import '../models/users.dart';

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
                ],
              ),
          ],
        ),
      ),
    );
  }
}
