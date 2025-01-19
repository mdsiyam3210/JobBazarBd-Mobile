
import 'package:common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/appbar2.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/util/heading/employer_heading_buttons.dart';
import 'package:jobbazar_mobile/shared/util/jobs_accordion.dart';
import 'package:provider/provider.dart';

import '../../../provider/job_provider.dart';



class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  late List<Job> jobs = [];
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController jobSalaryController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  void fetchJobs() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final jobProvider = Provider.of<JobProvider>(context, listen: false);
        jobProvider.fetchJobsByEmployer(userId: authProvider.currentUser?.id);
        jobs = jobProvider.employerJobs.reversed.toList();
        debugPrint(jobs.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final jobProvider = Provider.of<JobProvider>(context, listen: true);
    return Theme(
      data: employerTheme, // Apply the custom theme here
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const Appbar2(),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Column(
                children: [
                  // HeadingText(title: "Welcome, ${authProvider.currentUser?.name}", subtitle: "Your Companies Posted Jobs", subtitle2: "${jobs.length} Jobs Found",),
                  const EmployerHeadingButtons(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.teal),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text("New Job"),
                                content: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: jobTitleController,
                                          decoration: const InputDecoration(
                                            labelText: "Job Title",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: jobLocationController,
                                          decoration: const InputDecoration(
                                            labelText: "Job Description",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: jobDescriptionController,
                                          decoration: const InputDecoration(
                                            labelText: "Job Location",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: jobSalaryController,
                                          decoration: const InputDecoration(
                                            labelText: "Job Salary",
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          hint: const Text("Job Type"),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "FULL_TIME",
                                              child: Text("Full Time"),
                                            ),
                                            DropdownMenuItem(
                                              value: "PART_TIME",
                                              child: Text("Part Time"),
                                            ),
                                            DropdownMenuItem(
                                              value: "CONTRACT",
                                              child: Text("Contract"),
                                            ),
                                            DropdownMenuItem(
                                              value: "INTERNSHIP",
                                              child: Text("Internship"),
                                            ),
                                          ], 
                                          onChanged: (value) {
                                            jobTypeController.text = value ?? "";
                                          }
                                        )
                                      ],
                                    )
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.teal),
                                      foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)
                                    ),
                                    child: const Text("Submit"),
                                    onPressed: () async {
                                      try {
                                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                        final jobProvider = Provider.of<JobProvider>(context, listen: false);
                                        var jobData = {
                                          "title": jobTitleController.text,
                                          "description": jobDescriptionController.text,
                                          "salary": int.parse(jobSalaryController.text),
                                          "location": jobLocationController.text,
                                          "type": jobTypeController.text,
                                          "employer": {
                                              "id": authProvider.currentUser!.id,
                                              "username": authProvider.currentUser!.email,
                                              "role": authProvider.currentUser!.role
                                          },
                                          "company": authProvider.currentUser!.name
                                        };
                                        debugPrint(jobData.toString());
                                        await jobProvider.postJob(jobData);
                                        Navigator.pushNamed(context, '/employerHome');
                                        Constants.showSnackbar(context, "Job Posted Successfully");
                                      } catch (e) {
                                        debugPrint(e.toString());
                                        Constants.showSnackbar(context, "ERROR Occured During Job Posting, Have u typed all fields correctly?");
                                      }
                                    })
                                ],
                              );
                            }
                          );
                        }, 
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.black),
                            Text("Post New Job", style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),)
                          ]
                        )
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (jobs.isNotEmpty) {
                        return Consumer<JobProvider>(
                          builder: (context, jobProvider, child) {
                            return HotJobsAccordion(
                              jobs: jobProvider.employerJobs.reversed.toList(),
                              isAppliedJobs: false,
                            );
                          },
                        );

                      } else {
                        fetchJobs();
                        return const Center(child: Text("No Jobs? Post Some Above", style: TextStyle(
                          fontSize: 30
                        ),));
                      }
                    }
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
