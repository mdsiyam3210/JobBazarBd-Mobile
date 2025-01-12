import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/pages/employee/applied_jobs/applied_jobs_wrapper.dart';
import 'package:jobbazar_mobile/pages/employee/cv_page/cv_page.dart';
import 'package:jobbazar_mobile/pages/employer/all_jobs_posted/all_jobs.dart';
import 'package:jobbazar_mobile/pages/employer/hiring_tips/hiring_tips.dart';
import 'package:jobbazar_mobile/shared/pages/job_info.dart';
import 'package:jobbazar_mobile/pages/employee/learning/learning.dart';
import 'package:jobbazar_mobile/pages/employer/home/home.dart';
import 'package:jobbazar_mobile/pages/login/login.dart';
import 'package:jobbazar_mobile/pages/register/register.dart';
import 'package:jobbazar_mobile/pages/employee/home/home.dart'; // Assume a home page exists
import 'package:jobbazar_mobile/shared/pages/paid_plans.dart';
import 'package:jobbazar_mobile/shared/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        debugPrint("Wrapper: Authenticated: ${authProvider.isAuthenticated}, Role: ${authProvider.userType}");
        
        if (authProvider.isAuthenticated) {
          Future.delayed(Duration.zero, () {
          if (authProvider.userType == "USER") {
            debugPrint("Wrapper: Redirecting to userHome");
            Navigator.pushReplacementNamed(context, '/userHome');
            // return const EmployeeHomeScreen(title: 'JobBazar Mobile - Home');
          } else if (authProvider.userType == "EMPLOYER") {
            debugPrint("Wrapper: Redirecting to employerHome");
            Navigator.pushReplacementNamed(context, '/employerHome');
            // return const LearningScreen();
          }});
        }
        debugPrint("Wrapper: Redirecting to login");
        return const LoginScreen(); // Redirect unauthenticated users to login
      },
    );
  }
}



// class RouteToEmployer extends StatelessWidget {
//   const RouteToEmployer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }



var appRoutes = {
  '/': (context) => const Wrapper(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/userHome': (context) => const EmployeeHomeScreen(title: 'JobBazar Mobile - Home',),
  '/employerHome': (context) => const EmployerHomeScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/employee/learning': (context) => const LearningScreen(),
  '/jobInfo': (context) => const JobInfo(),
  '/paidPlans': (context) => const PaidPlansPage(),
  '/employer/allJobs': (context) => const AllJobsPage(),
  '/employee/cvInfo': (context) => const CVInformationScreen(),
  '/employer/hiringTips': (context) => const HiringTipsPage(),
  '/employee/appliedJobs': (context) => const AppliedJobs(),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // final authProvider = Provider.of<AuthProvider>(navigatorKey.currentContext!);

  // if (settings.name == '/userHome' && !authProvider.isAuthenticated) {
  //   // Redirect unauthenticated users to login
  //   return MaterialPageRoute(builder: (_) => const LoginScreen());
  // }

  // Default routes
  return MaterialPageRoute(
    builder: (context) => appRoutes[settings.name]!(context),
  );
}
