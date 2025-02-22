import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EmployeeHeadingButtons extends StatelessWidget {
  const EmployeeHeadingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Container(
      // height: 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFFE8F1F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(
                icon: Icons.edit_document,
                label: "CV Info",
                iconColor: Colors.indigo,
                onPressed: () {
                  Navigator.pushNamed(context, '/employee/cvInfo');
                },
              ),
              _buildButton(
                icon: Icons.business_center,
                label: "Applied Jobs",
                iconColor: Colors.teal,
                onPressed: () {
                  Navigator.pushNamed(context, '/employee/appliedJobs');
                },
              ),
              _buildButton(
                icon: Icons.school,
                label: "Courses",
                iconColor: Colors.orangeAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/employee/learning');
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(
                icon: Icons.attach_money,
                label: "Paid Plans",
                iconColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/paidPlans');
                },
              ),
              _buildButton(
                icon: Icons.question_mark,
                label: "FAQ",
                iconColor: Colors.purpleAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/faq');
                },
              ),
              _buildButton(
                icon: Icons.logout,
                label: "Logout",
                iconColor: Colors.redAccent,
                onPressed: () {
                  authProvider.logout(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 80, // Consistent width for all buttons
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(icon, size: 40, color: iconColor),
              splashRadius: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF354A54),
            ),
          ),
        ],
      ),
    );
  }
}
