import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/shared/util/hyperlink_text.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController roleController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Please fill in your details to register",
                          style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
                        ),
                        const SizedBox(height: 30),
                        
                        _buildTextField(
                          controller: nameController,
                          label: "Name",
                          icon: Icons.person,
                          hint: "Type your name here",
                        ),
                        
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: phoneController,
                          label: "Phone Number",
                          icon: Icons.phone,
                          hint: "Type your phone number here",
                        ),
                        
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: usernameController,
                          label: "Email",
                          icon: Icons.email,
                          hint: "Type your email here",
                        ),
                        
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: passwordController,
                          label: "Password",
                          icon: Icons.lock,
                          hint: "Type your password here",
                          obscureText: true,
                        ),
                        
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "I am looking for:",
                                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.8,
                                child: DropdownButtonFormField<String>(
                                  value: roleController.text.isEmpty ? null : roleController.text,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "USER",
                                      child: Text("A Job"),
                                    ),
                                    DropdownMenuItem(
                                      value: "EMPLOYER",
                                      child: Text("Employees/Staff"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    roleController.text = value ?? "";
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Select Role",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () async {
                                final authProvider = Provider.of<AuthProvider>(context, listen: false);

                                String username = usernameController.text.trim();
                                String password = passwordController.text.trim();
                                String phone = phoneController.text.trim();
                                String name = nameController.text.trim();
                                String role = roleController.text.trim();

                                Map<String, dynamic> data = {
                                  "name": name,
                                  "username": username,
                                  "password": password,
                                  "phone_number": phone,
                                  "role": role,
                                };

                                try {
                                  await authProvider.register(data);
                                  Navigator.pushReplacementNamed(context, '/login');
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Registration failed: ${e.toString()}')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),

                        HyperlinkText(
                          text: "Already Registered?",
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for creating the text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    bool obscureText = false,
  }) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blueAccent),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}