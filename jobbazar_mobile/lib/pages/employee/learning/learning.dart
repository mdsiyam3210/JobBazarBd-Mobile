import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy course data
    final List<Map<String, String>> courses = [
      {
        'title': 'Ace Your Resume',
        'description': 'Create a powerful resume recruiters love.',
        'duration': '2 hours',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScMW2rTK_DG2vH37ff2jSYUdjpQ_UVYQFS2w&s',
      },
      {
        'title': 'Master the Job Interview',
        'description': 'Learn techniques to confidently tackle interviews.',
        'duration': '3 hours',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRj-qIwyhkiaBzo1JcsS69Vzx1AcL1wNlNL7g&s',
      },
      {
        'title': 'LinkedIn Profile Boost',
        'description': 'Optimize your LinkedIn profile to get noticed.',
        'duration': '1.5 hours',
        'image': 'https://static.vecteezy.com/system/resources/previews/018/930/480/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png',
      },
      {
        'title': 'Networking Like a Pro',
        'description': 'Build connections to land your dream job.',
        'duration': '2.5 hours',
        'image': 'https://wallpapercave.com/wp/wp2044697.jpg',
      },
      {
        'title': 'Effective Communication',
        'description': 'Polish your workplace communication skills.',
        'duration': '2 hours',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOsBbRmkpaoLPnz9R3ShqoNjw5laMnBdS11Q&s',
      },
      // https://dummyimage.com/300x150
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Courses to Get Hired',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Explore top-notch courses tailored to help you land your dream job.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle browse all action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Browse All Courses'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Courses List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to course details
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.blue.shade100],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Course Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                course['image']!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Course Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['title']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    course['description']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Duration: ${course['duration']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // appBar: SharedAppBar(
      //   title: "JobBazar Mobile - Courses",
      //   color: Theme.of(context).primaryColor,
      // ),
      appBar: const PageAppbar(
        title: "Learning Page",
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
