import 'package:flutter/material.dart';

class EmployeeHeadingButtons extends StatelessWidget {
  const EmployeeHeadingButtons({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
              _buildButton(
                icon: Icons.business_center,
                label: "Applied Jobs",
                iconColor: Colors.teal,
                onPressed: () {},
              ),
              _buildButton(
                icon: Icons.school,
                label: "Courses",
                iconColor: Colors.orangeAccent,
                onPressed: () {},
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
                onPressed: () {},
              ),
              _buildButton(
                icon: Icons.notifications,
                label: "Notification",
                iconColor: Colors.purpleAccent,
                onPressed: () {},
              ),
              _buildButton(
                icon: Icons.logout,
                label: "Logout",
                iconColor: Colors.redAccent,
                onPressed: () {},
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
