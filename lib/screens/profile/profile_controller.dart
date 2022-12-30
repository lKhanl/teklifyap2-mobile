import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Base.dart';
import '../../models/profile_model.dart';

class ProfileController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  get profile => _getProfile();

  Future<Profile> _getProfile() async {
    final response =
        await http.get(Uri.parse("${Base.url}/api/v2/user/profile"), headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvZ3V6aGFuZXJjZWxpa0BnbWFpbC5jb20iLCJleHAiOjE2NzIzNDkxMDcsImlhdCI6MTY3MjI2MjcwN30.NpYYELI9qI1pNWsYmkt9H2pRwkoy0IOdRUcHeqsL8gcSiV6Ot1lZYCEroI4ecmlBKPhfBOjeAmkd7mEgeZlpIg",
    });
    if (response.statusCode == 200) {
      var result = Profile.fromJson(json.decode(response.body)['data']);
      return result;
    } else {
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
          "Authorization":
              "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvZ3V6aGFuZXJjZWxpazJAZ21haWwuY29tIiwiZXhwIjoxNjcyMzU0NzA5LCJpYXQiOjE2NzIyNjgzMDl9.M2nDH8uMGjhdYMVcXnW95ppCSRZAilcPYPmmeqWMCfKmvGmxY1eyAwzEaCsIQAk6rZerQsTxd3vBPA7dsaOsZw",
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      throw Exception('Failed to load post');
    }
  }
}
