import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/api/models/profile_model.dart';
import 'package:http/http.dart' as http;

import '../../api/Base.dart';

class ProfileController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
  }

  get profile => _getProfile();

  Future<Profile> _getProfile() async {
    final response =
        await http.get(Uri.parse("${Base.url}/api/v2/user/profile"),
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvZ3V6aGFuZXJjZWxpa0BnbWFpbC5jb20iLCJleHAiOjE2NzIwNjc4ODAsImlhdCI6MTY3MTk4MTQ4MH0.MT9tDCMl-oqm-NWSn7fPun3j1HcbUQOkT1dMBHwl82Ki4AY179FCojYA2RhMoqW3sAdUIoz0ZwwCR64VEKXllg",
        });
    if (response.statusCode == 200) {
      var result = Profile.fromJson(json.decode(response.body)['data']);
      print(response.body);
      return result;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
