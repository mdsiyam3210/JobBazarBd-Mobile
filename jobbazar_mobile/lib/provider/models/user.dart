class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final int phone;
  final bool isAuthenticated;
  final String role;

  User({required this.id, required this.name, required this.email, required this.phone, required this.isAuthenticated, required this.role, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['username'],
      phone: json['phone_number'],
      isAuthenticated: false,
      role: json['role'],
      password: json['password'],
    );
  }
}
