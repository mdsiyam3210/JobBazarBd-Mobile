import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/appbar.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/util/card/card_list.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:provider/provider.dart';

import '../../../provider/job_provider.dart';



class EmployerHomeScreen extends StatelessWidget {
  const EmployerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);

    final currentUser = authProvider.currentUser;
    jobProvider.fetchJobsByEmployer(userId: currentUser?.id);

    final jobs = jobProvider.employerJobs.reversed.toList();

    // debugPrint("${Theme.of(context).colorScheme.primary}");
    // debugPrint("${jobs[0].company}");
    // Use the Theme widget to apply employer theme to this screen only
    return Theme(
      data: employerTheme, // Apply the custom theme here
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: SharedAppBar(
              title: "JobBazar Mobile - Employer Home", 
              color: Theme.of(context).colorScheme.primary, // Using the theme color
            ),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    HeadingText(title: "Welcome, ${authProvider.currentUser?.name}", subtitle: "Your Companies Posted Jobs", subtitle2: "${jobs.length} Jobs Found",),
                    CardList(jobs: jobs, theme: employerTheme,),
                  ],
                ),
              ),
            )
          );
        }
      ),
    );
  }
}
