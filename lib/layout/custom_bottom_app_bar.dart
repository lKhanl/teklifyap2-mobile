import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/screens/inventory/inventory_screen.dart';
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';
import 'package:teklifyap_mobil2/screens/make_offer/make_offer_screen.dart';
import 'package:teklifyap_mobil2/screens/offer/offer_screen.dart';

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
            icon: const Icon(Icons.warehouse),
            onPressed: () {
              if (widget.from != BottomAppBarType.inventory) {
                Get.offAll(() => const InventoryScreen());
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.local_offer_rounded),
            onPressed: () {
              if (widget.from != BottomAppBarType.offers) {
                Get.offAll(() => const OfferScreen());
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (widget.from != BottomAppBarType.makeOffer) {
                Get.offAll(() => const MakeOfferScreen());
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (widget.from != BottomAppBarType.profile) {
                Get.offAll(() => const ProfileScreen());
              }
            },
          ),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                GetStorage().write('token', '');
                Get.offAll(() => const LoginScreen());
              }),
        ],
      ),
    );
  }
}
