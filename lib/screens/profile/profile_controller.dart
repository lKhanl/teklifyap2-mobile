import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/style/colors.dart';

import '../../Base.dart';
import '../../models/profile_model.dart';
import '../initial/initial_screen.dart';

class ProfileController extends GetxController {
  late String token;

  @override
  void onInit() async {
    super.onInit();
    token = GetStorage().read('token');
    if (token == "") {
      GetStorage().write('token', '');
      Get.offAll(() => const InitialScreen());
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
      throw Exception('Failed to load post');
    }
  }

  void updateProfile(
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
      Get.snackbar("Successfully", "Updated profile!",
          backgroundColor: ThemeColors.success);
    } else {
      Get.snackbar("Error", response.body, colorText: ThemeColors.error);
    }
  }

  Future<void> deleteProfile() async {
    final response =
        await http.delete(Uri.parse("${Base.url}/api/v2/user"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Get.snackbar("Successfully", "Check your email to delete your account!",
          backgroundColor: ThemeColors.success, colorText: Colors.white);
    } else {
      Get.snackbar("Error", response.body,
          backgroundColor: ThemeColors.error, colorText: Colors.white);
    }
  }
}
