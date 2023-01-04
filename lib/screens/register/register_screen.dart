import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';
import 'package:teklifyap_mobil2/screens/register/register_controller.dart';

import '../../layout/custom_header.dart';
import '../../layout/custom_text_field.dart';
import '../../style/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String name;
  late String surname;
  late String email;
  late String password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _controller = RegisterController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode isClickedEmail = FocusNode();
  late FocusNode isClickedPassword = FocusNode();
  late FocusNode isClickedName = FocusNode();
  late FocusNode isClickedSurname = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ThemeColors.primaryColor,
              ThemeColors.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomHeader(title: 'Register Form'),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          placeholder: 'Name',
                          controller: _nameController,
                          prefixIcon: Icon(Icons.person),
                          onChange: (value) {
                            name = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          placeholder: 'Surname',
                          controller: _surnameController,
                          prefixIcon: Icon(Icons.person),
                          onChange: (value) {
                            surname = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          placeholder: 'Email',
                          controller: _emailController,
                          prefixIcon: Icon(Icons.email),
                          onChange: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          placeholder: 'Password',
                          controller: _passwordController,
                          prefixIcon: Icon(Icons.lock),
                          onChange: (value) {
                            password = value;
                          },
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _controller.register(
                                  name, surname, email, password);
                            },
                            child: const Text('Register',
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: ThemeColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account?'),
                            TextButton(
                              onPressed: () {
                                Get.offAll(() => const LoginScreen());
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.transparent,
                              ),
                              child: Text(
                                'Login now',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
