import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/application_provider.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/pages/args/job_args.dart';
import 'package:provider/provider.dart';

class AppliedJobsButton extends StatefulWidget {
  final Job job;
  final ThemeData? theme;
  const AppliedJobsButton({super.key, required this.job, this.theme});

  @override
  State<AppliedJobsButton> createState() => _AppliedJobsButtonState();
}

class _AppliedJobsButtonState extends State<AppliedJobsButton> {
  @override
  Widget build(BuildContext context) {
    // final jobProvider = Provider.of<JobProvider>(context);
    // ignore: unused_local_variable
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/jobInfo', arguments: JobArgs(title: widget.job.title, description: widget.job.description, location: widget.job.location, salary: widget.job.salary, company: widget.job.company, jobType: widget.job.type, theme: widget.theme));
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue)
            ), 
            child: const Text("Get Info", style: TextStyle(color: Colors.black),)
          ),
        // ElevatedButton(
        //   onPressed: () {
        //     setState(() {
        //       debugPrint(widget.appId.toString());
        //       // applicationProvider.deleteApplication(appId: widget.appId, context: context);
        //       Navigator.pushNamed(context, '/employee/appliedJobs');
        //     });
        //   },
        //   style: const ButtonStyle(
        //     backgroundColor: WidgetStatePropertyAll(Color.fromARGB(220, 173, 34, 24))
        //   ), 
        //   child: const Text("Delete", style: TextStyle(color: Colors.black),)
        // ),
      ]
    );
  }
}