import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Base.dart';
import '../../style/colors.dart';
import '../profile/profile_screen.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  void login(String email, String pass) => _login(email, pass);

  void _login(String email, String pass) async {
    final response = await http.post(Uri.parse("${Base.url}/auth"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": pass,
        }));
    if (response.statusCode == 200) {
      var token = json.decode(response.body)['data'];
      GetStorage().write('token', token);
      Get.offAll(() => ProfileScreen());
    } else {
      if (response.body.contains('BadCredentials')) {
        Get.snackbar('Error', 'Bad Credentials',
            backgroundColor: ThemeColors.error);
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    }
  }
}
