
class Cv {
  final int? id;
  final int? userId;
  final String? name;
  final String? email;
  final double? phone;
  final String? location;
  final String? skills;
  final int? experience;
  final String? degree;
  final String? institute;
  final int? passingYear;
  final double? cgpa;
  Cv({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.location,
    this.skills,
    this.experience,
    this.degree,
    this.institute,
    this.passingYear,
    this.cgpa,
    this.userId
  });

  factory Cv.fromJson(Map<String, dynamic> json) {
    return Cv(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone_number'],
      location: json['location'],
      skills: json['skills'],
      experience: json['experience'],
      degree: json['degree'],
      institute: json['institute'],
      passingYear: json['passing_year'],
      cgpa: json['cgpa'],
      userId: json['user_id']
    );
  }
}