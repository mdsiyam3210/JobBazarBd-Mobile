
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/cv.dart';
import 'package:jobbazar_mobile/provider/services/cv_service.dart';

class CvProvider with ChangeNotifier {
  final CvService _cvService = CvService();
  Cv _currentUserCV = Cv();

  get currentUserCv => _currentUserCV;

  Future<void> fetchCv(int userId) async {
    try {
      _currentUserCV = await _cvService.getCvByUserId(userId);
    } catch (e) {
      _currentUserCV = Cv();
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }
}