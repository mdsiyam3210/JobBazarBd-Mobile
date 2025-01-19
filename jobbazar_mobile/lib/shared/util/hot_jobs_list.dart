import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';

class HotJobsList extends StatelessWidget {
  final List<Job> jobs;

  const HotJobsList({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: jobs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final job = jobs[index];
          return JobListItem(
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

class JobListItem extends StatelessWidget {
  final String companyName;
  final String? companyLogo;
  final String? location;
  final VoidCallback onViewNow;

  const JobListItem({
    super.key,
    required this.companyName,
    this.companyLogo,
    this.location,
    required this.onViewNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo
          if (companyLogo != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                companyLogo!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
          else
            const SizedBox(width: 50, height: 50), // Placeholder for no logo
          const SizedBox(width: 12),
          // Job Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (location != null)
                  Text(
                    location!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // View Now Button
          ElevatedButton(
            onPressed: onViewNow,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero, // Compact button
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'View Now',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
