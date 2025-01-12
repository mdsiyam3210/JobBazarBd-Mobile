import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/provider/job_provider.dart';
import 'package:jobbazar_mobile/shared/appbar.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/util/card/card_list.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:jobbazar_mobile/shared/util/search.dart';
import 'package:provider/provider.dart';

class AllJobsPage extends StatefulWidget {
  const AllJobsPage({super.key});

  @override
  State<AllJobsPage> createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<AllJobsPage> {
  late ValueNotifier<List<Job>> jobNotifier;

  @override
  void initState() {
    super.initState();
    jobNotifier = ValueNotifier<List<Job>>([]);
  }

  @override
  Widget build(BuildContext context) {
    JobProvider jobProvider = Provider.of<JobProvider>(context);
    if (jobProvider.jobs.isEmpty) {
      jobProvider.fetchJobs();
    }

    List<Job> jobs = jobProvider.jobs.reversed.toList();

    if (jobNotifier.value != jobs) {
      jobNotifier.value = jobs;
    }

    return Theme(
      data: employerTheme, 
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: SharedAppBar(title: "JobBazar Mobile - All Jobs", color: Theme.of(context).colorScheme.primary),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const HeadingText(title: "All Jobs Posted",),
                    SearchWidget(
                      onSearch: (query) {
                        debugPrint(query);
                        var filterJobs = jobs.where(
                          (job) => job.title.toLowerCase().contains(query.toLowerCase())).toList();
                        jobNotifier.value = filterJobs;
                        debugPrint(filterJobs.toString());
                        debugPrint("job notifier ${jobNotifier.value.toString()}");
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: jobNotifier,
                      builder: (context, filteredJobs, _) {
                        return CardList(jobs: filteredJobs);
                      },
                    ),
                  ]
                ),
              ),
            )
          );
        }
      )
    );
  }
}