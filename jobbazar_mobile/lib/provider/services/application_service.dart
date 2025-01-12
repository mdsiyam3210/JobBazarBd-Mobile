
import 'dart:convert';

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
}