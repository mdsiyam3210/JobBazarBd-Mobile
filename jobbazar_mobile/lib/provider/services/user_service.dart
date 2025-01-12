import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobbazar_mobile/provider/models/user.dart';

class UserService {
  final String apiUrl = "http://10.0.2.2:8080/api/users";

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => User.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<User> getUserByUsername({username}) async {
    final String newApiUrl = '$apiUrl/$username';
    try {
      debugPrint('Fetching user from: $newApiUrl', wrapWidth: 1024);
      final response = await http.get(Uri.parse(newApiUrl));
      debugPrint('Response: ${response.statusCode}', wrapWidth: 1024);

      if (response.statusCode == 200) {
        // Decode the JSON response to a Map
        Map<String, dynamic> responseMap = json.decode(response.body);
        
        // Convert the Map to a User object using the fromJson method
        User user = User.fromJson(responseMap);
        
        return user;
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<User> registerUser({dynamic userData}) async {
    final newApiUrl = '$apiUrl/register';
    try {
      final response = await http.post(
        Uri.parse(newApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap);
      return user;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}