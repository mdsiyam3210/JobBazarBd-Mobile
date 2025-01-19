import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/util/card/wrapper/card_button_wrapper.dart';

class CardList extends StatefulWidget {
  final List<Job> jobs;
  final ThemeData? theme;
  const CardList({super.key, required this.jobs, this.theme});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  late List<Job> filteredJobs;

  @override
  Widget build(BuildContext context) {
    filteredJobs = List<Job>.from(widget.jobs);
    return Flexible(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0, 
          childAspectRatio: 0.8,  
        ),
        itemCount: widget.jobs.length,
        itemBuilder: (BuildContext context, int index) {
          final job = widget.jobs[index];
          return Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  // Handle tap, show detailed job page or modal
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1.0), // Thin border for subtle separation
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job Icon and Title Side by Side
                        Row(
                          children: [
                            Icon(Icons.work_outline, size: 50, color: Colors.blue.shade500),
                            const SizedBox(width: 12), // Space between icon and title
                            Expanded(
                              child: Text(
                                job.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
              
                        //  const SizedBox(height: 12), 
                        Text(
                          'Company: ${job.company}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Divider(),
                    
                        // Card Button for Action
                        Center(child: CardButtonWrapper(job: job, theme: widget.theme)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
