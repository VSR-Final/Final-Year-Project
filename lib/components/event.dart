import 'package:flutter/material.dart';
import 'package:finalyearproject/components/exercises.dart';

class Event{
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final String name;
  final String exerciseID;
  final bool isAppointment;
  final String appointmentID;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.isAllDay = false,
    required this.name,
    required this.exerciseID,
    required this.appointmentID,
    required this.isAppointment,
});
}