
import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<Cv> createCv({required int userId, required dynamic data}) async {
    var newApiUrl = "$apiUrl/$userId";
    try {
      final response = await http.post(
        Uri.parse(newApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cv = Cv.fromJson(data);
        return cv;
      } else {
        debugPrint('Failed to create CV');
        throw Exception('Failed to create CV');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Cv> updateCv({required int userId, required dynamic data}) async {
    var newApiUrl = "$apiUrl/$userId";
    try {
      final response = await http.put(
        Uri.parse(newApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cv = Cv.fromJson(data);
        return cv;
      } else {
        debugPrint('Failed to create CV');
        throw Exception('Failed to create CV');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error: $e');
    }
  }
}