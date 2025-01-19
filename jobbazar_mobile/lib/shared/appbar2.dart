import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Appbar2 extends StatelessWidget implements PreferredSizeWidget {
  const Appbar2({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.currentUser!.role == "USER") {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80, // Adjusted height for a custom design
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                    'http://10.0.2.2:8080/api/uploads/pfp/${authProvider.currentUser?.id}'), // Replace with user's profile image URL
              ),
              const SizedBox(width: 16),
              // Name and Phone Number
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authProvider.currentUser!.name, // Replace with user's name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+${authProvider.currentUser!.phone}', // Replace with user's phone number
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Edit Button
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blueAccent, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    else {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80, // Adjusted height for a custom design
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade800,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                    'http://10.0.2.2:8080/api/uploads/pfp/${authProvider.currentUser?.id}'), // Replace with user's profile image URL
              ),
              const SizedBox(width: 16),
              // Name and Phone Number
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authProvider.currentUser!.name, // Replace with user's name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+${authProvider.currentUser!.phone}', // Replace with user's phone number
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Edit Button
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blueAccent, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}