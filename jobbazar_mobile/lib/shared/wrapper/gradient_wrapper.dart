import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:provider/provider.dart';

var userGradient = LinearGradient(
  colors: [Colors.blue.shade800, Colors.blue.shade600],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var employerGradient = LinearGradient(
  colors: [Colors.teal.shade800, Colors.teal.shade600],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class GradientWrapper extends StatelessWidget {
  const GradientWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.currentUser?.role == "USER") {
      return Container(
        decoration: BoxDecoration(
          gradient: userGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: employerGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    }
  }
}