import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:jobbazar_mobile/shared/util/jobs_accordion.dart';
import 'package:jobbazar_mobile/shared/util/search.dart';
import 'package:provider/provider.dart';

class AllJobsPage extends StatefulWidget {
  const AllJobsPage({super.key});

  @override
  State<AllJobsPage> createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<AllJobsPage> {
  late Future<List<Job>> _jobsFuture;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Memoize the fetchJobs Future
    _jobsFuture = fetchJobs();
  }

  Future<List<Job>> fetchJobs() async {
    JobProvider jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.fetchJobs();
    return jobProvider.jobs.reversed.toList();
  }

  List<Job> filterJobs(List<Job> jobs, String query) {
    return jobs
        .where((job) => job.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: employerTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const PageAppbar(title: "All Jobs Posted"),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const HeadingText(title: "All Jobs Posted"),
                    SearchWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query.toLowerCase();
                        });
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<List<Job>>(
                        future: _jobsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error fetching jobs: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No jobs available'),
                            );
                          } else {
                            // Filter jobs based on the search query
                            final filteredJobs =
                                filterJobs(snapshot.data!, searchQuery);

                            return HotJobsAccordion(
                              jobs: filteredJobs,
                              isAppliedJobs: true,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
