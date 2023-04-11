import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';

class PatientDetailPage extends StatefulWidget {
  Users patient;
  Users physiotherapist;
  PatientDetailPage(this.patient, this.physiotherapist);

  @override
  _PatientDetailPageState createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
 
  @override
  Widget build(BuildContext context) {
  }
}