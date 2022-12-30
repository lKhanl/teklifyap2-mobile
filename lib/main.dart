import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/screens/home/home_screen.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

void main() {
  runApp(const Teklifyap());
}

class Teklifyap extends StatelessWidget {
  const Teklifyap({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teklifyap',
      home: Home(),
    );
  }
}
