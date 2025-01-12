import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:jobbazar_mobile/shared/appbar.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/util/heading/heading_text.dart';

class HiringTipsPage extends StatelessWidget {
  const HiringTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: employerTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: SharedAppBar(title: "JobBazar Mobile - Hiring Tips", color: Theme.of(context).colorScheme.primary),
            drawer: const AppDrawer(),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(title: "Employer Dashboard", subtitle: "Hiring Tips",),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          buildCard(
                            'Write Clear Job Descriptions',
                            'Detail the role responsibilities and requirements to attract the right candidates.',
                          ),
                          buildCard(
                            'Use Social Media',
                            'Leverage social platforms to reach a larger pool of talent.',
                          ),
                          buildCard(
                            'Streamline the Interview Process',
                            'Ensure a quick and structured interview process to keep candidates engaged.',
                          ),
                          buildCard(
                            'Focus on Company Culture',
                            'Highlight your company culture to attract candidates who align with your values.',
                          ),
                          buildCard(
                            'Offer Competitive Compensation',
                            'Provide salaries and benefits that meet or exceed market standards.',
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
      ),
    );
  }

  Widget buildCard(String title, String description) {
    return Card(
      color: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Learn More',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}