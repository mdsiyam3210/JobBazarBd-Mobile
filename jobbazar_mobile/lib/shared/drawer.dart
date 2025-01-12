import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/wrapper/drawer_wrapper.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String title;
    final LinearGradient userGradient;

    if (authProvider.userType == "USER") {
      title = "Employee Dashboard";
      userGradient = LinearGradient(
        colors: [Colors.blue.shade800, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (authProvider.userType == "EMPLOYER") {
      title = "Employer Dashboard";
      userGradient = LinearGradient(
        colors: [Colors.teal.shade800, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      title = "Dashboard";
      userGradient = LinearGradient(
        colors: [Colors.blue.shade800, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: userGradient,
                // borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          const DrawerWrapper(),
          const Divider(thickness: 1),

          const Spacer(),

          _buildLogoutTile(context, authProvider),
        ],
      ),
    );
  }

  // Logout button with improved design
  Widget _buildLogoutTile(BuildContext context, AuthProvider authProvider) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        size: 40,
        color: Colors.red,
      ),
      title: const Text(
        'Logout',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      onTap: () {
        authProvider.logout(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.red.withOpacity(0.1),
      hoverColor: Colors.red.withOpacity(0.2),
    );
  }
}
