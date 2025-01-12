import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/shared/pages/args/paid_plans_args.dart';

class EmployerDrawerItems extends StatelessWidget {
  const EmployerDrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDrawerItem(
          context,
          icon: Icons.edit_document,
          title: 'Job Postings',
          route: '/employer/allJobs',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.assignment_turned_in_outlined,
          title: 'Applications',
          route: '/employer/applications',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.attach_money,
          title: 'Paid Plans',
          route: '/paidPlans',
          arguments: PaidPlansArgs(theme: employerTheme, gradient: employerDecoration),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.notifications,
          title: 'Hiring Tips',
          route: '/employer/hiringTips',
        ),
      ],
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    Object? arguments,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 40, color: Colors.blueGrey),
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          onTap: () {
            Navigator.pushReplacementNamed(context, route, arguments: arguments);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.blueGrey.withOpacity(0.05),
          hoverColor: Colors.blueGrey.withOpacity(0.1),
        ),
        const Divider(indent: 20, endIndent: 20),
      ],
    );
  }
}
