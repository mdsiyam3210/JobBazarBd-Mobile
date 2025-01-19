import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/models/cv.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employer/employer_gradient.dart';
import 'package:jobbazar_mobile/shared/theme/employer/theme.dart';
import 'package:provider/provider.dart';

class ApplicationCvInfo extends StatefulWidget {
  final Cv cv;
  const ApplicationCvInfo({super.key, required this.cv});

  @override
  State<ApplicationCvInfo> createState() => ApplicationCvInfoState();
}

class ApplicationCvInfoState extends State<ApplicationCvInfo> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Theme(
      data: employerTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const PageAppbar(title: "CV Info"),
            bottomNavigationBar: const BottomNav(),
            body: Container(
              decoration: employerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // children: [
                              const Text(
                                "Candidate Information",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              // Expanded(
                              //   child: Image(
                              //     image: Image.network("http://10.0.2.2:8080/api/uploads/pfp/${widget.cv.userId}").image,
                              //     height: 100,
                              //     width: 100,
                              //   ),
                              // )
                            // ],
                          // ),
                          const SizedBox(height: 20),
                          buildInfoRow("Name", widget.cv.name),
                          buildInfoRow("Email", widget.cv.email),
                          buildInfoRow("Phone", widget.cv.phone?.toString()),
                          buildInfoRow("Location", widget.cv.location),
                          const Divider(),
                          const Text(
                            "Skills & Experience",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildInfoRow("Skills", widget.cv.skills),
                          buildInfoRow("Experience", "${widget.cv.experience ?? 0} years"),
                          const Divider(),
                          const Text(
                            "Education Details",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildInfoRow("Degree", widget.cv.degree),
                          buildInfoRow("Institute", widget.cv.institute),
                          buildInfoRow("Passing Year", widget.cv.passingYear?.toString()),
                          buildInfoRow("CGPA", widget.cv.cgpa?.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
