
import 'package:common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/application.dart';
import 'package:jobbazar_mobile/provider/services/application_service.dart';

class ApplicationProvider with ChangeNotifier {
  List<Application> _applications = [];
  final ApplicationService _applicationService = ApplicationService();

  List<Application> get applications => _applications;

  Future<void> fetchApplicationByUserId(int userId) async {
    try {
      _applications = await _applicationService.getApplicationsByUserId(userId: userId);
    } catch (e) {
      throw Exception('Error: $e');
    }
    finally {
      notifyListeners();
    }
  }

  Future<List<Application>> fetchApplicationByJobId(int jobId) async {
    try {
      var apps = await _applicationService.getApplicationsByJobId(jobId: jobId);
      return apps;
    } catch (e) {
      debugPrint("$e");
      throw Exception('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> applyForJob({required dynamic appData, required BuildContext context}) async {
    try {
      await _applicationService.applyForJob(appData: appData);
      Constants.showSnackbar(context, "Applied Succesfully!");
    } catch (e) {
      debugPrint('Error: $e');
      Constants.showSnackbar(context, "ERROR: Cant Apply For Job.");
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteApplication({required dynamic appId, required BuildContext context}) async {
    try {
      await _applicationService.deleteApplication(appId: appId);
      Constants.showSnackbar(context, "Application Deleted Succesfully!");
    } catch (e) {
      debugPrint('Error: $e');
      Constants.showSnackbar(context, "ERROR: Cant Delete Application.");
      throw Exception('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> makeApplicationDecision({required int appId, required String decision, required BuildContext context}) async {
    try {
      await _applicationService.makeApplicationDecision(appId: appId, decision: decision);
      Constants.showSnackbar(context, "Application Decision Updated Succesfully!");
    } catch (e) {
      debugPrint('Error: $e');
      Constants.showSnackbar(context, "ERROR: Cant Update Application Decision.");
      throw Exception('Error: $e');
    } finally {
      notifyListeners();
    }
  }
}