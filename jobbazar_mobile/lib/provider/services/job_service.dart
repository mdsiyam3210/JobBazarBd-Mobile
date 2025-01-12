
import 'dart:convert';
import 'package:jobbazar_mobile/provider/models/job.dart';
import 'package:http/http.dart' as http;

class JobService {
  final String apiUrl = "http://10.0.2.2:8080/api/jobs";

  Future<List<Job>> getJobs() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        var data = body.map((dynamic item) => Job.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Job>> getJobsByEmployer({dynamic userId}) async {
    final String newUrl = '$apiUrl/employer/$userId';
    try {
      final response = await http.get(Uri.parse(newUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        var data = body.map((dynamic item) => Job.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Job> getJobById(int id) async {
    final String newUrl = '$apiUrl/$id';
    try {
      final response = await http.get(Uri.parse(newUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(response.body);
        Job job = Job.fromJson(responseMap);
        return job;
      } else {
        throw Exception('Failed to load job');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}