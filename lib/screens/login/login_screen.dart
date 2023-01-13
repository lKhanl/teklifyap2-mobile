import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/layout/custom_header.dart';
import 'package:teklifyap_mobil2/layout/custom_text_field.dart';
import 'package:teklifyap_mobil2/screens/login/login_controller.dart';
import 'package:teklifyap_mobil2/screens/register/register_screen.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.put(LoginController());
  late String email = "oguzhanercelik@gmail.com";
  late String password = "Cayan123";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode isClickedEmail = FocusNode();

  late FocusNode isClickedPassword = FocusNode();

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
                  CustomHeader(title: 'Login Form'),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                              if (_formKey.currentState!.validate()) {
                                _controller.login(email, password);
                              }
                            },
                            child: const Text('Login',
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
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Get.offAll(() => const RegisterScreen());
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.transparent,
                              ),
                              child: Text(
                                'Register now',
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
