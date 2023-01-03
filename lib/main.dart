import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklifyap_mobil2/screens/initial/initial_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const Teklifyap());
}

class Teklifyap extends StatelessWidget {
  const Teklifyap({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'teklifyap',
      home: InitialScreen(),
    );
  }
}
