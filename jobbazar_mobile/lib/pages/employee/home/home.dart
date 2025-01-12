// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/pages/args/job_args.dart';
import 'package:jobbazar_mobile/shared/pages/job_info.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:jobbazar_mobile/shared/util/card/card_list.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:jobbazar_mobile/shared/util/heading/user_heading_buttons.dart';
import 'package:jobbazar_mobile/shared/util/search.dart';
import 'package:provider/provider.dart';

import '../../../provider/models/job.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<EmployeeHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EmployeeHomeScreen> {
  late ValueNotifier<List<Job>> jobNotifier;

  @override
  void initState() {
    super.initState();
    jobNotifier = ValueNotifier<List<Job>>([]);
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);
    if (jobProvider.jobs.isEmpty) {
      jobProvider.fetchJobs();
    }

    final jobs = jobProvider.jobs.reversed.toList();

    if (jobNotifier.value != jobs) {
      jobNotifier.value = jobs;
    }

    final currentUser = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
      ),
      body: Container(
        decoration: employeeDecoration,
        child: Column(
          children: [
            // HeadingText(title: "Welcome, ${currentUser?.name}", subtitle: "Apply to these jobs", subtitle2: "${jobs.length} Jobs Found",),
            const EmployeeHeadingButtons(),
            SearchWidget(
              onSearch: (query) {
                // debugPrint(query);
                var filterJobs = jobs.where(
                  (job) => job.title.toLowerCase().contains(query.toLowerCase())).toList();
                jobNotifier.value = filterJobs;
                // debugPrint(filterJobs.toString());
                // debugPrint("job notifier ${jobNotifier.value.toString()}");
              },
            ),
      
            ValueListenableBuilder(
              valueListenable: jobNotifier,
              builder: (context, filteredJobs, _) {
                return CardList(jobs: filteredJobs);
              },
            ),
          ],
        ),
      ),

      drawer: const AppDrawer(),

      bottomNavigationBar: const BottomNav()
    );
  }
}