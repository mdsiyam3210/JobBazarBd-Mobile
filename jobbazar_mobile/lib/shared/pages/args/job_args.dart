import 'package:flutter/material.dart';

class JobArgs {
  final String title;
  final String description;
  final String location;
  final double salary;
  final String company;
  final String jobType;
  final ThemeData? theme;

  JobArgs({this.theme, required this.title, required this.description, required this.location, required this.salary, required this.company, required this.jobType});
}