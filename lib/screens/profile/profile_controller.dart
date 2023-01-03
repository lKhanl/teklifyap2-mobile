import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';

import '../../Base.dart';
import '../../models/profile_model.dart';

class ProfileController extends GetxController {
  late String token;
  @override
  void onInit() async {
    super.onInit();
    token = GetStorage().read('token');
    if (token == "") {
      GetStorage().write('token', '');
      Get.offAll(() => const LoginScreen());
    }
  }

  get profile => _getProfile();

  Future<Profile> _getProfile() async {
    final response =
        await http.get(Uri.parse("${Base.url}/api/v2/user/profile"), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      var result = Profile.fromJson(json.decode(response.body)['data']);
      return result;
    } else {
      print(response.body);
      print(GetStorage().read('token'));
      throw Exception('Failed to load post');
    }
  }

  Future<bool> updateProfile(
      String name, String surname, String email, String password) async {
    final response =
        await http.put(Uri.parse("${Base.url}/api/v2/user/profile"),
            body: jsonEncode({
              "name": name,
              "surname": surname,
              "email": email,
              "password": password,
            }),
            headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.body);
      throw Exception('Failed to load post');
    }
  }
}
