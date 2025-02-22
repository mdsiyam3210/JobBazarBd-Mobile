import 'package:common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/profile_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/pages/args/profile_args.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    nameController.text = authProvider.currentUser?.name ?? "";
    emailController.text = authProvider.currentUser?.email ?? "";
    phoneController.text = authProvider.currentUser?.phone.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final ProfileArgs args = (ModalRoute.of(context)?.settings.arguments as ProfileArgs?) ?? ProfileArgs(theme: Theme.of(context));

    debugPrint("${args.theme?.primaryColor}");
    final authProvider = Provider.of<AuthProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    Image img = Image.network("http://10.0.2.2:8080/api/uploads/pfp/${authProvider.currentUser?.id}");

    return Theme(
      data: args.theme ?? Theme.of(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const PageAppbar(title: "Profile"),
            backgroundColor: args.theme?.colorScheme.secondary ?? Theme.of(context).colorScheme.secondary, // Background color
            bottomNavigationBar: const BottomNav(),
            drawer: const AppDrawer(),
            body: Center(
              child: Container(
                width: 350, // Card width
                height: 350,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture and Name
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: img.image,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${authProvider.currentUser?.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
          
                    // Phone
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Phone - ${authProvider.currentUser?.phone}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
          
                    // Email
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Email - ${authProvider.currentUser?.email}',
                          style: const TextStyle(color: Colors.lightBlue, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
          
                    // Password
                    const Row(
                      children: [
                        Icon(Icons.lock, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Password - #\$%!\$',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
          
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text("Edit Profile"),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Form(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              labelText: "Name",
                                            ),
                                          ),
                                          TextFormField(
                                            controller: emailController,
                                            decoration: const InputDecoration(
                                              labelText: "Email",
                                            ),
                                          ),
                                          TextFormField(
                                            controller: passwordController,
                                            decoration: const InputDecoration(
                                              labelText: "Password",
                                          )),
                                          TextFormField(
                                            controller: phoneController,
                                            decoration: const InputDecoration(
                                              labelText: "Phone",
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                                        foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)
                                      ),
                                      onPressed: () {
                                        if (nameController.text == "" || emailController.text == "" || passwordController.text == "" || phoneController.text == "") {
                                          Constants.showSnackbar(context, "Please Fill up All Fields");
                                        } else {
                                          var userData = {
                                            "name": nameController.text,
                                            "username": emailController.text,
                                            "password": passwordController.text,
                                            "phone_number": phoneController.text,
                                            "role": authProvider.currentUser!.role
                                          };
                                          debugPrint(userData.toString());
                                          authProvider.updateUser(userData, authProvider.currentUser!.id, context);
                                          authProvider.logout(context);
                                        }
                                      }, 
                                      child: const Text("Submit")
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: const Icon(Icons.edit, color: Colors.white,),
                          label: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await profileProvider.pickImage();
                            if (profileProvider.selectedImage != null) {
                              await profileProvider.uploadImage(authProvider.currentUser!.id);
                              setState(() {});
                              imageCache.clear();
                              imageCache.clearLiveImages();
                              Navigator.pushNamed(context, '/profile');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: const Icon(Icons.photo, color: Colors.white,),
                          label: const Text('Change Picture', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}