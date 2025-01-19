import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/application_provider.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/provider/models/application.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:provider/provider.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  List<Job> jobs = [];
  List<Application> applications = [];
  bool _isInitialized = false;

  Future<void> fetchData() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      final jobProvider = Provider.of<JobProvider>(context, listen: false);

      // debugPrint("user_id: ${authProvider.currentUser!.id}");

      applicationProvider.fetchApplicationByUserId(authProvider.currentUser!.id).whenComplete(() {
        applications = applicationProvider.applications.reversed.toList();
        // debugPrint("Applications: ${applications.length}");

        Future.wait(applications.map((application) async {
          // debugPrint("job.id: ${application.job_id}");
          final job = await jobProvider.fetchJobById(application.job_id);
          debugPrint("job: $job");
          setState(() {
            if (job != null) {
              jobs.add(job);
              // Navigator.pushNamed(context, '/employee/appliedJobs');
            } else {
              debugPrint("Job not found");
            }
          });
        })).then((_) {
          setState(() {
            // Navigator.pushNamed(context, '/employee/appliedJobs');
            _isInitialized = true;
            debugPrint("$_isInitialized");
          });
        });
      });
  }

  @override
  void initState() {
    super.initState();

    debugPrint("$_isInitialized");

    // if (!_isInitialized) {
      fetchData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    if (applications.isNotEmpty && _isInitialized) {
      return Scaffold(
        appBar: const PageAppbar(title: "Applied Jobs"),
        drawer: const AppDrawer(),
        bottomNavigationBar: const BottomNav(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: employeeDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeadingText(title: "Applied Jobs", subtitle: "${jobs.length} Jobs Found",),
                // FutureBuilder(
                //   future: fetchData() ,
                //   builder: (context, snapshot) => HotJobsAccordion(jobs: jobs),
                // )
                Builder(
                  builder: (context) {
                    if (applications.isNotEmpty) {
                      // return HotJobsAccordion(jobs: jobs, isAppliedJobs: true,);
                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.black,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Job Title")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Actions"))
                          ], 
                          rows: applications.map(
                            (application) => DataRow(
                              cells: [
                                DataCell(Text(application.job_title)),
                                DataCell(Builder(
                                  builder: (context) {
                                    if (application.status == "REJECTED") {
                                      return Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(
                                            color: Colors.black
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(application.status, style: const TextStyle(color: Colors.black),));
                                    } else if (application.status == "ACCEPTED") {
                                      return Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border.all(
                                            color: Colors.black
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(application.status, style: const TextStyle(color: Colors.black),));
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          border: Border.all(
                                            color: Colors.black
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(application.status, style: const TextStyle(color: Colors.black),));
                                    }
                                  }
                                )),
                                DataCell(
                                  TextButton(
                                    onPressed: () async {
                                      await applicationProvider.deleteApplication(appId: application.id, context: context);
                                      Navigator.pushNamed(context, '/employee/appliedJobs');
                                      // Navigator.pushNamed(context, '/employee/appliedJobs');
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(Colors.red),
                                      foregroundColor: WidgetStateProperty.all(Colors.white),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: const BorderSide(color: Colors.black)
                                        )
                                      )
                                    ),
                                    child: const Text("Delete"),
                                  )
                                )
                              ]
                            )
                          ).toList()
                        ),
                      );
                    } else { 
                      debugPrint("in if");
                      return const Scaffold(appBar: PageAppbar(title: "Applied Jobs"), body: Center(child: Text("Loading"),));
                    }
                  }
                )
              ]
            ),
          )
        ),
      );
    }
    else {
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      debugPrint("applicationProvider.applications: ${applicationProvider.applications.toString()}");
      if (applicationProvider.applications.isNotEmpty) {
        return const Center(child: Text("Loading"));
      } else {
        return const Scaffold(appBar: PageAppbar(title: "Applied Jobs"), body: Center(child: Text("No Jobs Applied", style: TextStyle(
          fontSize: 50
        ),)));
      }
    }
  }
}