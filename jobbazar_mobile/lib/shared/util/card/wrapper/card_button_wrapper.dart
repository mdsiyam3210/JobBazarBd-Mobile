import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/pages/args/job_args.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:provider/provider.dart';

class CardButtonWrapper extends StatelessWidget {
  final Job job;
  final ThemeData? theme;
  const CardButtonWrapper({super.key, required this.job, this.theme});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.userType == "USER") {
      return Column(
        // TODO: Implement Following Buttons
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/jobInfo', arguments: JobArgs(title: job.title, description: job.description, location: job.location, salary: job.salary, company: job.company, jobType: job.type, theme: theme));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)
              ), 
              child: const Text("Get Info", style: TextStyle(color: Colors.black),)
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(223, 233, 164, 60))
            ), 
            child: const Text("Apply", style: TextStyle(color: Colors.black),)
          ),
        ],
      );
    }
    else if (authProvider.userType == "EMPLOYER") {
      return Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/jobInfo', arguments: JobArgs(title: job.title, description: job.description, location: job.location, salary: job.salary, company: job.company, jobType: job.type, theme: theme));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)
              ), 
              child: const Text("Get Info", style: TextStyle(color: Colors.black),)
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(223, 233, 164, 60))
              ), 
              child: const Text("Update", style: TextStyle(color: Colors.black),)
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(220, 173, 34, 24))
            ), 
            child: const Text("Delete", style: TextStyle(color: Colors.black),)
          ),
        ],
      );
    }
    return const Placeholder();
  }
}