import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/pages/args/paid_plans_args.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';

class UserDrawerItems extends StatelessWidget {
  const UserDrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDrawerItem(
          context,
          icon: Icons.edit_document,
          title: 'CV Info',
          route: '/employee/cvInfo',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.work,
          title: 'Applied Jobs',
          route: '/employee/appliedJobs',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.attach_money,
          title: 'Paid Plans',
          route: '/paidPlans',
          arguments: PaidPlansArgs(gradient: employeeDecoration),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.notifications,
          title: 'Notifications',
          route: '/employee/notifications',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.school,
          title: 'Courses',
          route: '/employee/learning',
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
            Navigator.pushNamed(context, route, arguments: arguments);
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
