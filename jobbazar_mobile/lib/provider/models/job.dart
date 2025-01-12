class Job {
  final int id;
  final String title;
  final String description;
  final String location;
  final String type;
  final int employerId;
  final double salary;
  final String company;

  Job({required this.id, required this.title, required this.description, required this.location, required this.type, required this.employerId, required this.salary, required this.company});

factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? -1,
      title: json['title'] ?? 'Unknown Title',
      description: json['description'] ?? 'No Description',
      location: json['location'] ?? 'Unknown Location',
      type: json['type'] ?? 'Unknown Type',
      employerId: json['employerId'] ?? -1,
      salary: (json['salary'] as num?)?.toDouble() ?? 0.0,
      company: json['company'] ?? 'Unknown Company',
    );
  } 
}
