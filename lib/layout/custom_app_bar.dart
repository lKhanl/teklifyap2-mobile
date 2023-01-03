import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeColors.primaryColor,
      title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () {
            GetStorage().write('token', '');
            Get.offAll(() => const LoginScreen());
          },
        ),
      ],
    );
  }
}
