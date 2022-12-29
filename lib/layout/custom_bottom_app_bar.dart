import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/screens/home/home_screen.dart';

import '../screens/profile/profile_screen.dart';

class CustomBottomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomBottomAppBar({super.key, required this.from});

  final BottomAppBarType from;

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              if (widget.from != BottomAppBarType.home) {
                Get.offAll(() => const Home(email: "",password: "",));//parametreler deneme amaçlı
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.warehouse),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.local_offer_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (widget.from != BottomAppBarType.profile) {
                Get.offAll(() => const ProfileScreen());
              }
            },
          ),
        ],
      ),
    );
  }
}
