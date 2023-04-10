import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void acceptPatient(String patientEmail) async {
  final patientsRef = FirebaseFirestore.instance.collection('patients');
  final querySnapshot =
      await patientsRef.where('email', isEqualTo: patientEmail).get();

  final patientDoc = querySnapshot.docs.first;
  await patientDoc.reference.update({'status': 'accepted'});
}
