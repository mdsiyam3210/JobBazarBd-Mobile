
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/models/application.dart';
import 'package:http/http.dart' as http;

class ApplicationService {
  final String apiUrl = "http://10.0.2.2:8080/api/applications";

  Future<List<Application>> getApplicationsByUserId({dynamic userId}) async {
    final String newUrl = '$apiUrl/user/$userId';
    try {
      final response = await http.get(Uri.parse(newUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        var data = body.map((dynamic item) => Application.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Application>> getApplicationsByJobId({required int jobId}) async {
    final String newUrl = '$apiUrl/job/$jobId';
    try {
      final response = await http.get(Uri.parse(newUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        var data = body.map((dynamic item) => Application.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> applyForJob({required dynamic appData}) async {
    try {
      var jsonAppData = jsonEncode(appData);
      debugPrint(jsonAppData);
      final response = await http.post(Uri.parse(apiUrl), body: jsonAppData, headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        return response.body;
      } else {
        debugPrint(response.body);
        debugPrint('Failed to apply for job');
        throw Exception('Failed to apply for job');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<String> deleteApplication({required dynamic appId}) async {
    var newApiUrl = '$apiUrl/$appId';
    try {
      final response = await http.delete(Uri.parse(newApiUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        debugPrint('Failed to delete application');
        throw Exception('Failed to delete application');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Application> makeApplicationDecision({required int appId, required String decision}) async {
    var newApiUrl = '$apiUrl/$appId';
    try {
      final response = await http.put(Uri.parse(newApiUrl), 
      body: jsonEncode({"status": decision}), 
      headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        return Application.fromJson(jsonDecode(response.body));
      } else {
        debugPrint('Failed to make application decision');
        throw Exception('Failed to make application decision');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error: $e');
    }
  }
}