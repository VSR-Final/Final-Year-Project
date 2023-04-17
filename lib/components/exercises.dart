import 'package:flutter/material.dart';

class Exercises{
  final String exerciseID;
  final String downloadLink;
  final String fileName;
  final String name;
  final String physiotherapistID;

  const Exercises({
    required this.exerciseID,
    required this.downloadLink,
    required this.fileName,
    required this.name,
    required this.physiotherapistID,
  });
}