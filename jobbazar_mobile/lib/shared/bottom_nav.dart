import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/pages/args/profile_args.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 10
          )
        ]
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: Theme.of(context).colorScheme.onSurface, // Selected icon color
        unselectedItemColor: Theme.of(context).colorScheme.onSurface, // Unselected icon color
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30), // Slightly reduced icon size
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 30), // Slightly reduced icon size
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              if (authProvider.userType == "USER") {
                Navigator.pushReplacementNamed(context, '/userHome'); // Replaces current screen
              } else if (authProvider.userType == "EMPLOYER") {
                Navigator.pushReplacementNamed(context, '/employerHome');
              }
              break;
            case 1:
              if (authProvider.userType == "USER") {
                Navigator.pushReplacementNamed(context, '/profile');
              } else if (authProvider.userType == "EMPLOYER") {
                Navigator.pushReplacementNamed(context, '/profile', arguments: ProfileArgs(theme: employerTheme));
              }
              break;
          }
        },
        elevation: 50,
        // showSelectedLabels: true, 
        showUnselectedLabels: true, 
      ),
    );
  }
}
