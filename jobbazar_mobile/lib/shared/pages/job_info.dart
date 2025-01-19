import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/pages/args/job_args.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/util/info_row.dart';

class JobInfo extends StatelessWidget {
  const JobInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final JobArgs jobArgs = (ModalRoute.of(context)?.settings.arguments as JobArgs);
    debugPrint("${jobArgs.theme?.primaryColor}");

    return Theme(
      data: jobArgs.theme ?? Theme.of(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: jobArgs.theme?.colorScheme.secondary ?? Theme.of(context).colorScheme.secondary,
            appBar: const PageAppbar(title: "Job Info"),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("JOB INFO", style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                jobArgs.title,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Text(
                            //   jobArgs.description,
                            //   style: const TextStyle(fontSize: 16, color: Colors.black87),
                            // ),
                            const Divider(height: 24, color: Colors.grey),
                    
                            Column(
                              children: [
                                InfoRow(label: "Description", value: jobArgs.description),
                                InfoRow(label: "Location", value: jobArgs.location),
                                InfoRow(label: "Salary", value: "${jobArgs.salary}"),
                                InfoRow(label: "Company", value: jobArgs.company),
                                InfoRow(label: "Job Type", value: jobArgs.jobType),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}