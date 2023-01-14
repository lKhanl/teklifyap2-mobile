import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/layout/custom_button.dart';
import 'package:teklifyap_mobil2/layout/custom_text_field.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
            nameController.text = profile.name;
            surnameController.text = profile.surname;
            emailController.text = profile.email;
            passController.text = "";

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
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.45,
                          child: CustomTextField(
                            placeholder: "First Name",
                            controller: nameController,
                            onChange: (value) {
                              nameController.text = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.05,
                        ),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 20) * 0.45,
                          child: CustomTextField(
                            placeholder: 'Surname',
                            controller: TextEditingController(
                                text: profile.surname.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40),
                        child: CustomTextField(
                          controller: emailController,
                          placeholder: 'Email',
                          onChange: (value) {
                            emailController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40),
                        child: CustomTextField(
                          controller: passController,
                          placeholder: 'Password',
                          isPassword: true,
                          onChange: (value) {
                            passController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: (MediaQuery.of(context).size.width - 40),
                    child: CustomButton(
                      backgroundColor: ThemeColors.secondaryColor,
                      onPressed: () {
                        _controller.updateProfile(
                            nameController.text,
                            surnameController.text,
                            emailController.text,
                            passController.text);
                      },
                      title: 'Update',
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 40),
                    child: CustomButton(
                      backgroundColor: ThemeColors.error,
                      title: 'Delete Account',
                      onPressed: () {
                        _controller.deleteProfile();
                      },
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
