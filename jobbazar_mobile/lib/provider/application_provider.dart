
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
}