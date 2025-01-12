
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:jobbazar_mobile/provider/services/job_service.dart';

class JobProvider with ChangeNotifier {
  final JobService _jobService = JobService();
  List<Job> _jobs = [];
  Job? job;
  List<Job> _employerJobs = [];

  List<Job> get employerJobs => _employerJobs;
  List<Job> get jobs => _jobs;
  Job? get currentJob => job;

  Future<void> fetchJobs() async {
    try {
      _jobs = await _jobService.getJobs();
    } catch (e) {
      _jobs = [];
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchJobsByEmployer({dynamic userId}) async {
    try {
      _employerJobs = await _jobService.getJobsByEmployer(userId: userId);
    } catch (e) {
      _employerJobs = [];
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<Job?> fetchJobById(int jobId) async {
    try {
      return await _jobService.getJobById(jobId);
    } catch (e) {
      // debugPrint('Error: $e');
      // throw Exception('Error: $e');
    } finally {
      notifyListeners();
    }
  }


}