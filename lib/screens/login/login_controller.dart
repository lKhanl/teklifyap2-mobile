import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/screens/inventory/inventory_screen.dart';

import '../../Base.dart';
import '../../style/colors.dart';

class LoginController extends GetxController {
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
      Get.offAll(() => const InventoryScreen());
    } else {
      if (response.body.contains('BadCredentials')) {
        Get.snackbar('Error', 'Bad Credentials',
            backgroundColor: ThemeColors.error);
      } else {
        Get.snackbar('Error', response.body,
            backgroundColor: ThemeColors.error);
      }
    }
  }
}
