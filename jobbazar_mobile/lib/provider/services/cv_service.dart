
import 'dart:convert';

import 'package:jobbazar_mobile/provider/models/cv.dart';
import 'package:http/http.dart' as http;

class CvService {
  final String apiUrl = "http://10.0.2.2:8080/api/coverletter";

  Future<Cv> getCvByUserId(int userId) async {
    final String newApiUrl = "$apiUrl/$userId";
    try {
      final response = await http.get(Uri.parse(newApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cv = Cv.fromJson(data);
        return cv;
      } else {
        throw Exception('Failed to load CV');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}