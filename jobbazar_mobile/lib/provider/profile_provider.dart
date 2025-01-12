
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobbazar_mobile/provider/services/file_service.dart';

class ProfileProvider with ChangeNotifier {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final FileService _fileService = FileService();

  File? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    } catch (e) {
      throw Exception("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<String> uploadImage(int userId) async {
    try {
      if (_selectedImage == null) {
        return "No image selected";
      }
      return await _fileService.uploadPfp(_selectedImage!, userId);
    } catch (e) {
      throw Exception("Error: $e");
    } 
  }
}