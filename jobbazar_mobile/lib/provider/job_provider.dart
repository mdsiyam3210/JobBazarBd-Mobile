
import 'package:common_constants/common_constants.dart';
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
      return;
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
    return null;
  }

  Future<void> postJob(dynamic data) async {
    try {
      await _jobService.postJob(data);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Job posted successfully');
      notifyListeners();
    }
  }

  Future<void> updateJob(int jobId, Map<String, dynamic> jobData, BuildContext context) async {
    try {
      await _jobService.updateJob(jobId, jobData);
      Constants.showSnackbar(context, "Job Updated Succesfully");
    } catch (e) {
      debugPrint('Error: $e');
      Constants.showSnackbar(context, "ERROR: Cant Update Job");
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteJob(int jobId) async {
    try {
      await _jobService.deleteJob(jobId);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

}