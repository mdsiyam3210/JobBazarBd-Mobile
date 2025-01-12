import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? subtitle2;
  const HeadingText({super.key, required this.title, this.subtitle, this.subtitle2,});

  @override
  Widget build(BuildContext context) {
    if (subtitle == null && subtitle2 == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: Text(title, style: const TextStyle(
              fontSize: 30,
            ),))]),
      );
    }
    if (subtitle2 == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: Text(title, style: const TextStyle(
              fontSize: 30,
            ),)),
        
            Center(child: Text(subtitle ?? "", style: const TextStyle(
              color: Color.fromARGB(255, 15, 82, 226),
              fontSize: 24
            ),)),
          ]
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          children: [
            Center(child: Text(title, style: const TextStyle(
              fontSize: 30,
            ),)),
            Center(child: Text(subtitle ?? "", style: const TextStyle(
              color: Color.fromARGB(255, 15, 82, 226),
              fontSize: 24
            ),)),
        
            Text(subtitle2 ?? "", style: const TextStyle(
              fontSize: 20,
            )),]),
      );
      }
  }
}