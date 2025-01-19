import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/pages/args/paid_plans_args.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';

class PaidPlansPage extends StatelessWidget {
  const PaidPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaidPlansArgs args = (ModalRoute.of(context)?.settings.arguments as PaidPlansArgs?) ?? PaidPlansArgs(theme: Theme.of(context));

    return Theme(
      data: args.theme ?? Theme.of(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const PageAppbar(title: "Paid Plans"),
            bottomNavigationBar: const BottomNav(),
            drawer: const AppDrawer(),
            body: Container(
              decoration: args.gradient ?? employeeDecoration,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Page Title
                    const Text(
                      'Select the plan that fits your needs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                        
                    // Subscription Plans
                    Expanded(
                      child: ListView(
                        children: [
                          _buildPlanCard(
                            context,
                            title: "Basic Plan",
                            price: "\$9.99/month",
                            features: ["Access to basic features", "Email support"],
                            backgroundColor: Colors.green[200],
                            buttonColor: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          _buildPlanCard(
                            context,
                            title: "Standard Plan",
                            price: "\$19.99/month",
                            features: [
                              "Access to all features",
                              "Priority email support",
                              "Weekly insights"
                            ],
                            backgroundColor: Colors.blue[100],
                            buttonColor: Colors.blue,
                            isPopular: true,
                          ),
                          const SizedBox(height: 16),
                          _buildPlanCard(
                            context,
                            title: "Premium Plan",
                            price: "\$29.99/month",
                            features: [
                              "All Standard features",
                              "Dedicated account manager",
                              "24/7 chat support",
                              "Advanced analytics"
                            ],
                            backgroundColor: Colors.orange[100],
                            buttonColor: const Color.fromARGB(255, 255, 128, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required List<String> features,
    required Color? backgroundColor,
    required Color buttonColor,
    bool isPopular = false,
  }) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: Colors.black, // Set the color of the border
              width: 4, // Set the width of the border
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) {
                    return Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Text(feature),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle subscription logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(child: Text('Subscribe Now', style: TextStyle(color: Colors.white),)),
                ),
              ],
            ),
          ),
        ),
        if (isPopular)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Popular',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
