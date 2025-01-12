
import 'dart:io';

import 'package:dio/dio.dart';

class FileService {
  String apiUrl = "10.0.2.2:8080/api/uploads"; 
  final Dio _dio = Dio();

  Future<String> uploadPfp(File image, int userId) async {
    try {
      String newApiUrl = "http://$apiUrl/pfp/$userId";

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path)
      });

      Response response = await _dio.post(newApiUrl, data: formData);
      if (response.statusCode == 200) {
        return "Image uploaded successfully";
      } else {
        return "Image upload failed";
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}