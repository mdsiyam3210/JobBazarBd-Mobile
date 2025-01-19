import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';

class HotJobsGrid extends StatelessWidget {
  final List<Job> jobs;

  const HotJobsGrid({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.2, // Compact card proportions
        ),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return JobCard(
            companyName: job.title,
            companyLogo: "https://dummyimage.com/600x400",
            location: job.location,
            onViewNow: () {
              debugPrint('View Now tapped for: ${job.title}');
            },
          );
        },
      ),
    );
  }
}


class JobCard extends StatelessWidget {
  final String companyName;
  final String? companyLogo;
  final String? location;
  final VoidCallback onViewNow;

  const JobCard({
    super.key,
    required this.companyName,
    this.companyLogo,
    this.location,
    required this.onViewNow,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Company Logo (Optional)
          if (companyLogo != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                companyLogo!,
                height: 60, // Reduced height for compactness
                fit: BoxFit.cover,
              ),
            ),
          // Card Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Name
                Text(
                  companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Reduced font size
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Location (Optional)
                if (location != null)
                  Text(
                    location!,
                    style: TextStyle(
                      fontSize: 11, // Reduced font size
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                // View Now Button
                ElevatedButton(
                  onPressed: onViewNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero, // Adjusted for compact button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Now',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

