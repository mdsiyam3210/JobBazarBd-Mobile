// ignore_for_file: non_constant_identifier_names

class Application {
  final int id;
  final Map<String, dynamic> coverLetter;
  final String status;
  final int job_id;
  final String job_title;
  final int applicant_id;
  final int cover_letter_id;
  final String applicant_name;

  Application({
    required this.id,
    required this.coverLetter,
    required this.status,
    required this.job_id,
    required this.job_title,
    required this.applicant_id,
    required this.cover_letter_id,
    required this.applicant_name
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      coverLetter: json['coverLetter'],
      status: json['status'],
      job_id: json['job_id'],
      job_title: json['job_title'],
      applicant_id: json['applicant_id'],
      cover_letter_id: json['cover_letter_id'],
      applicant_name: json['applicant_name']
    );
  }
}