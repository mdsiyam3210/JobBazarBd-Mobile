import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/appbar.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:jobbazar_mobile/shared/util/card/card_list.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';

class AppliedJobsPage extends StatelessWidget {
  final List<Job> jobs;
  const AppliedJobsPage({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    if (jobs != []) {
      return Scaffold(
        appBar: SharedAppBar(title: "JobBazar Mobile - Applied Jobs", color: Theme.of(context).colorScheme.primary,),
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
                CardList(jobs: jobs),
              ]
            ),
          )
        ),
      );
    }
    else {
      return const CircularProgressIndicator();
    }
  }
}