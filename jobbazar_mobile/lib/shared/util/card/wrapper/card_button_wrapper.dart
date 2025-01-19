import 'package:common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/application_provider.dart';
import 'package:jobbazar_mobile/provider/cv_provider.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/shared/pages/args/job_args.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:provider/provider.dart';

class CardButtonWrapper extends StatefulWidget {
  final Job job;
  final ThemeData? theme;
  const CardButtonWrapper({super.key, required this.job, this.theme});

  @override
  State<CardButtonWrapper> createState() => _CardButtonWrapperState();
}

class _CardButtonWrapperState extends State<CardButtonWrapper> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobLocationController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobSalaryController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobTitleController.text = widget.job.title;
    jobLocationController.text = widget.job.location;
    jobDescriptionController.text = widget.job.description;
    jobSalaryController.text = widget.job.salary.toString();
    jobTypeController.text = widget.job.type;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final cvProvider = Provider.of<CvProvider>(context);
    final appProvider = Provider.of<ApplicationProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);


    if (authProvider.userType == "USER") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobInfo', arguments: JobArgs(title: widget.job.title, description: widget.job.description, location: widget.job.location, salary: widget.job.salary, company: widget.job.company, jobType: widget.job.type,));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)
              ), 
              child: const Text("Get Info", style: TextStyle(color: Colors.black),)
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await cvProvider.fetchCv(authProvider.currentUser!.id).whenComplete(() async {
                try {
                  if (cvProvider.currentUserCv.id == null) {
                    Constants.showSnackbar(context, "Fill up Your CV First");
                    Navigator.pushNamed(context, "/employee/cvInfo");
                  }
                  final Map<String, dynamic> appData = {
                    "jobId": widget.job.id,
                    "userId": authProvider.currentUser!.id,
                    "status": "PENDING",
                    "coverLetter": {
                        "id": cvProvider.currentUserCv.id,
                        "user_id": authProvider.currentUser!.id
                    }
                  };
                  await appProvider.applyForJob(appData: appData, context: context);
                  Navigator.pushNamed(context, '/employee/appliedJobs');
                } catch (e) {
                  debugPrint(e.toString());
                  // Constants.showSnackbar(context, "ERROR Occured During Job Application");
                }
              });
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(223, 233, 164, 60))
            ), 
            child: const Text("Apply", style: TextStyle(color: Colors.black),)
          ),
        ],
      );
    }
    else if (authProvider.userType == "EMPLOYER") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobInfo', arguments: JobArgs(title: widget.job.title, description: widget.job.description, location: widget.job.location, salary: widget.job.salary, company: widget.job.company, jobType: widget.job.type, theme: employerTheme));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)
              ), 
              child: const Text("Get Info", style: TextStyle(color: Colors.black),)
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("Update Job"),
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
                                hint: Text(jobTypeController.text),
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
                                    value: "CONTRACTUAL",
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
                          onPressed: () async {
                            debugPrint("update clicked");
                            try {
                              final Map<String, dynamic> jobData = {
                                "title": jobTitleController.text,
                                "description": jobDescriptionController.text,
                                "location": jobLocationController.text,
                                "salary": jobSalaryController.text,
                                "type": jobTypeController.text
                              };
                              debugPrint(widget.job.toString());
                              debugPrint(jobTitleController.text);
                              await jobProvider.updateJob(widget.job.id, jobData, context);
                              Navigator.pushNamed(context, '/employerHome');
                            } catch (e) {
                              debugPrint(e.toString());
                              Constants.showSnackbar(context, "ERROR Occured During Job Posting, Have u typed all fields correctly?");
                            }
                            // jobProvider.updateJob(jobData: jobData, context: context);
                          },
                          child: const Text("Update"),
                        ),
                      ],
                    );
                  }
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(223, 233, 164, 60))
              ), 
              child: const Text("Update", style: TextStyle(color: Colors.black),)
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                jobProvider.deleteJob(widget.job.id);
                Navigator.pushNamed(context, '/employerHome');
              });
            },
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