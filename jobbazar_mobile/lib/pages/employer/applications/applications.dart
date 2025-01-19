import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/pages/employer/applications/applications_table.dart';
import 'package:jobbazar_mobile/provider/application_provider.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:provider/provider.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  late List<Job> jobs = [];

  fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.fetchJobsByEmployer(userId: authProvider.currentUser!.id);
    jobs = jobProvider.employerJobs.reversed.toList();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final jobProvider = Provider.of<JobProvider>(context);
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    return Theme(
      data: employerTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const PageAppbar(title: "Applications"),
            bottomNavigationBar: const BottomNav(),
            drawer: const AppDrawer(),
            body: Container(
              decoration: employerDecoration,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  jobs.isEmpty
                      ? const HeadingText(title: "View Applications For Jobs")
                      : HeadingText(
                          title: "View Applications For Jobs",
                          subtitle: "${jobs.length} Jobs found",
                        ),
                  Expanded(
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          if (jobs.isNotEmpty) {
                            return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: DataTable(
                                  headingRowColor:
                                      WidgetStateProperty.all(Colors.grey[200]),
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        "No.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Title",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Actions",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: jobs
                                      .map(
                                        (job) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(
                                                "${jobs.indexOf(job) + 1}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                job.title,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              ElevatedButton.icon(
                                                onPressed: () async {
                                                  var applications =
                                                      await applicationProvider
                                                          .fetchApplicationByJobId(
                                                              job.id);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ApplicationsTable(
                                                              applications:
                                                                  applications),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                    Icons.visibility),
                                                label: const Text("View"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.teal,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            );
                          } else {
                            fetchData();
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
