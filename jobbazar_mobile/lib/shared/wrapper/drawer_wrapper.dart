import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/pages/employee/drawer_items/user_drawer.dart';
import 'package:jobbazar_mobile/pages/employer/drawer_items/employer_drawer.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class DrawerWrapper extends StatelessWidget {
  const DrawerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.userType == "USER") {
      return const UserDrawerItems();
    }
    else if (authProvider.userType == "EMPLOYER") {
      return const EmployerDrawerItems();
    }
    return const Placeholder();
  }
}