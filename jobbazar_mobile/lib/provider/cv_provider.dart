
import 'dart:io';

import 'package:common_constants/common_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/cv.dart';
import 'package:jobbazar_mobile/provider/services/cv_service.dart';
import 'package:jobbazar_mobile/provider/services/file_service.dart';

class CvProvider with ChangeNotifier {
  final CvService _cvService = CvService();
  final FileService _fileService = FileService();
  Cv _currentUserCV = Cv();
  File? _currentUserCvFile;

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

  Future<void> createCv({required int userId, required dynamic data}) async {
    try {
      _currentUserCV = await _cvService.createCv(userId: userId, data: data);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateCv({required int userId, required dynamic data}) async {
    try {
      _currentUserCV = await _cvService.updateCv(userId: userId, data: data);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        _currentUserCvFile = File(result.files.single.path!);
        debugPrint("File Picked");
        Constants.showSnackbar(context, "Cv Uploaded Succesfully");
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint("${_currentUserCvFile?.path}");
      notifyListeners();
    }
  }

  Future<String> uploadCv(int userId) async {
    try {
      if (_currentUserCvFile == null) {
        return "No file selected";
      }
      return await _fileService.uploadCv(_currentUserCvFile!, userId);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}