import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';

import '../../Base.dart';
import '../../style/colors.dart';

class RegisterController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  void register(String name, String surname, String email, String pass) =>
      _register(name, surname, email, pass);

  void _register(String name, String surname, String email, String pass) async {
    final response = await http.post(Uri.parse("${Base.url}/auth/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "surname": surname,
          "email": email,
          "password": pass,
        }));
    if (response.statusCode == 200) {
      Get.snackbar('Done', 'Login successful, check your email!',
          backgroundColor: ThemeColors.success);
      Future.delayed(const Duration(milliseconds: 10),
          () => Get.offAll(() => LoginScreen()));
    } else {
      Get.snackbar('Error', response.body, backgroundColor: ThemeColors.error);
    }
  }
}
