import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teklifyap_mobil2/api/models/profile_model.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/screens/profile/profile_controller.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.profile),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: _controller.profile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var profile = snapshot.data as Profile;
                      return Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                )
      ),
            Text(
              // '${profileProvider.user!.name} ${profileProvider.user!.surname}',
              'Ahmet Ak',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "dasd",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
