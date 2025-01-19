import 'package:common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/provider/auth_provider.dart';
import 'package:jobbazar_mobile/provider/cv_provider.dart';
import 'package:jobbazar_mobile/shared/bottom_nav.dart';
import 'package:jobbazar_mobile/shared/drawer.dart';
import 'package:jobbazar_mobile/shared/page_appbar.dart';
import 'package:jobbazar_mobile/shared/theme/employee/employee_gradient.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CvPage extends StatefulWidget {
  const CvPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CvPageState createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  String name = "";
  String email = "";
  String phone = "";
  String location = "";
  String skills = "";
  String experience = "";
  String degree = "";
  String institute = "";
  String passingYear = "";
  String cgpa = "";
  bool _hasCv = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController passingYearController = TextEditingController();
  final TextEditingController cgpaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cvProvider = Provider.of<CvProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    cvProvider.fetchCv(authProvider.currentUser!.id).whenComplete(() {
      setState(() {
        name = cvProvider.currentUserCv?.name ?? authProvider.currentUser!.name;
        email = cvProvider.currentUserCv?.email ?? authProvider.currentUser!.email;
        phone = authProvider.currentUser!.phone.toString();
        location = cvProvider.currentUserCv?.location ?? "";
        skills = cvProvider.currentUserCv?.skills ?? "";
        experience = cvProvider.currentUserCv?.experience.toString() ?? "";
        degree = cvProvider.currentUserCv?.degree ?? "";
        institute = cvProvider.currentUserCv?.institute ?? "";
        passingYear = cvProvider.currentUserCv?.passingYear.toString() ?? "";
        cgpa = cvProvider.currentUserCv?.cgpa.toString() ?? "";

        debugPrint(cvProvider.currentUserCv.toString());

        if (cvProvider.currentUserCv.location != null) {
          _hasCv = true;
        }

        // Update controllers after setting the state
        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
        locationController.text = location;
        skillsController.text = skills;
        experienceController.text = experience;
        degreeController.text = degree;
        instituteController.text = institute;
        passingYearController.text = passingYear;
        cgpaController.text = cgpa;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CvProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const PageAppbar(title: "Your CV"),
      bottomNavigationBar: const BottomNav(),
      drawer: const AppDrawer(),
      body: Container(
            decoration: employeeDecoration,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    // initialValue: name,
                    controller: nameController,
                    enabled: false,
                    readOnly: true,
                    enableInteractiveSelection: false,

                    decoration: InputDecoration(
                      labelText: 'Name (Disabled)',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // floatingLabelAlignment: FloatingLabelAlignment.center,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                    onSaved: (value) => name = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: email,
                    controller: emailController,
                    enabled: false,
                    readOnly: true,
                    enableInteractiveSelection: false,

                    decoration: InputDecoration(
                      labelText: 'Email (Disabled)',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                    onSaved: (value) => email = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: phone,

                    enabled: false,
                    readOnly: true,
                    enableInteractiveSelection: false,

                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone (Disabled)',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your phone number'
                        : null,
                    onSaved: (value) => phone = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: location,
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your location'
                        : null,
                    onSaved: (value) => location = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: skills,
                    controller: skillsController,
                    decoration: InputDecoration(
                      labelText: 'Skills',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your skills' : null,
                    onSaved: (value) => skills = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: experience,
                    controller: experienceController,
                    decoration: InputDecoration(
                      labelText: 'Years Of Experience',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your experience' : null,
                    onSaved: (value) => experience = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // initialValue: degree,
                    controller: degreeController,
                    decoration: InputDecoration(
                      labelText: 'Degree',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your degree' : null,
                    onSaved: (value) => degree = value!,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: instituteController,
                    // initialValue: institute,
                    decoration: InputDecoration(
                      labelText: 'Institute',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your institute' : null,
                    onSaved: (value) => institute = value!,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passingYearController,
                    // initialValue: passingYear,
                    decoration: InputDecoration(
                      labelText: 'Passing Year',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your passing year'
                        : null,
                    onSaved: (value) => passingYear = value!,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: cgpaController,
                    // initialValue: cgpa,
                    decoration: InputDecoration(
                      labelText: 'CGPA',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      filled: true,
                      fillColor: Colors.black.withOpacity(.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      isDense: true
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your CGPA' : null,
                    onSaved: (value) => cgpa = value!,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: !_hasCv ? () {
                          try {
                            final cvData = {
                              "user": authProvider.currentUser!.id,
                              "name": nameController.text,
                              "phone_number": double.parse(phoneController.text),
                              "location": locationController.text,
                              "skills": skillsController.text,
                              "experience": experienceController.text,
                              "institute": instituteController.text,
                              "degree": degreeController.text,
                              "passing_year": int.parse(passingYearController.text),
                              "cgpa": cgpaController.text,
                              "email": emailController.text
                            };
                            debugPrint(cvData.toString());
                            debugPrint("first function, $_hasCv");
                            cvProvider.createCv(userId: authProvider.currentUser!.id, data: cvData);
                            Navigator.pushReplacementNamed(context, '/employee/cvInfo');
                          } catch (e) {
                            debugPrint(e.toString());
                            Constants.showSnackbar(context, "ERROR Occured During CV Action, Have u typed all fields?");
                          }

                          // _createCv(cvData);
                        } : () {
                          try {
                            final cvData = {
                              "user": authProvider.currentUser!.id,
                              "name": nameController.text,
                              "phone_number": double.parse(phoneController.text),
                              "location": locationController.text,
                              "skills": skillsController.text,
                              "experience": experienceController.text,
                              "institute": instituteController.text,
                              "degree": degreeController.text,
                              "passing_year": int.parse(passingYearController.text),
                              "cgpa": cgpaController.text,
                              "email": emailController.text
                            };
                            debugPrint("second function, $_hasCv");
                            debugPrint(cvData.toString());
                            cvProvider.updateCv(userId: authProvider.currentUser!.id, data: cvData);
                            Navigator.pushReplacementNamed(context, '/employee/cvInfo');
                          } catch (e) {
                            Constants.showSnackbar(context, "ERROR Occured During CV Action, Have u typed all fields?");
                          }
                        },
                          style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          backgroundColor: const Color.fromARGB(223, 233, 164, 60),
                          foregroundColor: Colors.black,
                        ),
                        child: !_hasCv ? const Text('Upload CV') : const Text('Update CV', style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await cvProvider.pickFile(context);
                            await cvProvider.uploadCv(authProvider.currentUser!.id);
                            // Constants.showSnackbar(context, "CV uploaded successfully");
                          } catch (e) {
                            debugPrint(e.toString());
                            Constants.showSnackbar(context, "ERROR Occured During CV Action, Have u correctly Uploaded File?");
                          }
                        }, 
                        child: const Text("Upload CV File")
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final Uri url = Uri.parse("http://10.0.2.2:8080/api/uploads/pdf/${authProvider.currentUser!.id}");
                          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                            Constants.showSnackbar(context, "Could not launch $url");
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: const Text("View Cv File")
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }
}
