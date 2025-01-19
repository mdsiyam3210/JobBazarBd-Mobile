import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/shared/util/card/wrapper/applied_jobs_button.dart';
import 'package:jobbazar_mobile/shared/util/card/wrapper/card_button_wrapper.dart';

class HotJobsAccordion extends StatefulWidget {
  final List<Job> jobs;
  final bool isAppliedJobs;

  const HotJobsAccordion({super.key, required this.jobs, required this.isAppliedJobs});

  @override
  State<HotJobsAccordion> createState() => _HotJobsAccordionState();
}

class _HotJobsAccordionState extends State<HotJobsAccordion> {
  late List<bool> _isExpanded; // Track the expansion state for each job

  @override
  void initState() {
    super.initState();
    _isExpanded = List<bool>.filled(widget.jobs.length, false);
  }

  @override
  void didUpdateWidget(HotJobsAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the jobs list has changed, and if so, re-initialize _isExpanded
    if (widget.jobs.length != oldWidget.jobs.length) {
      _isExpanded = List<bool>.filled(widget.jobs.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("$_isExpanded");
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 4),
              elevation: 1,
              animationDuration: const Duration(milliseconds: 300),
              expansionCallback: (int index, bool isExpanded) {
                debugPrint("Expansion callback triggered for index $index, isExpanded: $isExpanded");
                setState(() {
                  // _isExpanded[index] = !isExpanded;
                  if (isExpanded) {
                    _isExpanded[index] = true;
                  } else {
                    _isExpanded[index] = false;
                  }
                });
              },
              children: widget.jobs.map<ExpansionPanel>((job) {
                final index = widget.jobs.indexOf(job);
                return ExpansionPanel(
                  isExpanded: _isExpanded[index],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://dummyimage.com/600x400", 
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          job.title,
                          style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                        ),
                        subtitle: Text(
                          job.location,
                          style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                        ),
                      ),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: widget.isAppliedJobs ? AppliedJobsButton(job: job, theme: Theme.of(context)) : CardButtonWrapper(key: ValueKey(job.id), job: job),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
