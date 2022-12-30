import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/screens/profile/profile_controller.dart';

import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../models/profile_model.dart';
import '../../style/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = Get.put(ProfileController());
  String name = "";
  String surname = "";
  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: const CustomAppBar(title: "Profile"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.profile),
      body: FutureBuilder(
        future: _controller.profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profile = snapshot.data as Profile;
            name = profile.name;
            surname = profile.surname;
            email = profile.email;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeColors.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          child: Text(
                            profile.name[0].toUpperCase() +
                                profile.surname[0].toUpperCase(),
                            style: const TextStyle(fontSize: 36),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.45,
                          child: TextField(
                            controller: TextEditingController(
                                text: profile.name.toString()),
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.05,
                        ),
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.45,
                          child: TextField(
                            controller: TextEditingController(
                                text: profile.surname.toString()),
                            onChanged: (value) {
                              surname = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Surname',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 40),
                        child: TextField(
                          controller: TextEditingController(
                              text: profile.email.toString()),
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 40),
                        child: TextField(
                          controller: TextEditingController(text: pass),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          onChanged: (value) {
                            pass = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: (MediaQuery.of(context).size.width - 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.secondaryColor,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _controller
                            .updateProfile(name, surname, email, pass)
                            .then((value) => printInfo(info: value.toString()))
                            .catchError(
                                (error) => printError(info: error.toString()));
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
            color: ThemeColors.secondaryColor,
          ));
        },
      ),
    );
  }
}
