import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/cv_provider.dart';
import 'package:jobbazar_mobile/shared/appbar.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';
import 'package:provider/provider.dart';

class CVInformationScreen extends StatelessWidget {
  const CVInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CvProvider cvProvider = Provider.of<CvProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    cvProvider.fetchCv(authProvider.currentUser!.id);
    return Scaffold(
      appBar: SharedAppBar(title: "JobBazar Mobile - CV Information", color: Theme.of(context).colorScheme.primary),
      drawer: const AppDrawer(),
      bottomNavigationBar: const BottomNav(),
      body: Container(
        decoration: employeeDecoration,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText(title: "CV Information"),
              const SizedBox(height: 20),
              // Fields
              _buildFieldRow("Name*", "Safwan Sadid", "Phone Number*", "5425475544778"),
              _buildFieldRow("Location*", "Chittagong", "Email*", "safu@yahoo.com"),
              _buildFieldRow("Skills*", "Python", "Years Of Experience*", "5"),
              _buildFieldRow("Institute*", "BUET", "Degree*", "CSE"),
              _buildFieldRow("Passing Year*", "2021", "CGPA*", "4"),
              const SizedBox(height: 20),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton("Update CV", Colors.blue),
                  _buildButton("Upload CV File", Colors.pink),
                  _buildButton("View CV", Colors.cyan),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldRow(
      String label1, String value1, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildField(label1, value1),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildField(label2, value2),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const TextField(
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
      ],
    );
  }

  Widget _buildButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
