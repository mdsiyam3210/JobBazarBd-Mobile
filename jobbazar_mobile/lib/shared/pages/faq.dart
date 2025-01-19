import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:provider/provider.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    debugPrint(authProvider.currentUser!.role);
    if (authProvider.currentUser!.role == "EMPLOYER") {
      return Theme(
        data: employerTheme,
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: const PageAppbar(title: "FAQ"),
              bottomNavigationBar: const BottomNav(),
              drawer: const AppDrawer(),
              body: Container(
                decoration: employerDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: const [
                      FAQItem(
                        question: "How do I apply for a job?",
                        answer: "To apply for a job, simply go to the job listing, and click the 'Apply' button. You may need to upload your resume and cover letter.",
                      ),
                      FAQItem(
                        question: "How can I reset my password?",
                        answer: "To reset your password, go to the login page, click on 'Forgot Password', and follow the instructions sent to your email.",
                      ),
                      FAQItem(
                        question: "Can I save jobs for later?",
                        answer: "Yes! You can save jobs by clicking the 'Save' icon. Your saved jobs will be accessible under the 'Saved Jobs' section in your profile.",
                      ),
                      FAQItem(
                        question: "How can I edit my profile?",
                        answer: "You can edit your profile by going to the 'Profile' section and clicking on 'Edit Profile'. From there, you can update your information and resume.",
                      ),
                      FAQItem(
                        question: "Is there a website?",
                        answer: "Currently, the website is fully up and running and very much functional",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      );
    } else {
      return Scaffold(
        appBar: const PageAppbar(title: "FAQ"),
        bottomNavigationBar: const BottomNav(),
        drawer: const AppDrawer(),
        body: Container(
          decoration: employeeDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                FAQItem(
                  question: "How do I apply for a job?",
                  answer: "To apply for a job, simply go to the job listing, and click the 'Apply' button. You may need to upload your resume and cover letter.",
                ),
                FAQItem(
                  question: "How can I reset my password?",
                  answer: "To reset your password, go to the login page, click on 'Forgot Password', and follow the instructions sent to your email.",
                ),
                FAQItem(
                  question: "Can I save jobs for later?",
                  answer: "Yes! You can save jobs by clicking the 'Save' icon. Your saved jobs will be accessible under the 'Saved Jobs' section in your profile.",
                ),
                FAQItem(
                  question: "How can I edit my profile?",
                  answer: "You can edit your profile by going to the 'Profile' section and clicking on 'Edit Profile'. From there, you can update your information and resume.",
                ),
                FAQItem(
                  question: "Is there a website?",
                  answer: "Currently, the website is fully up and running and very much functional",
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}