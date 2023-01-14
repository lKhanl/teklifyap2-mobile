import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/screens/offer/offer_controller.dart';

import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../style/colors.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final OfferController _controller = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: const CustomAppBar(title: "Offers"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.offers),
      body: FutureBuilder(
        // future: _controller.profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // var profile = snapshot.data as Profile;

            return Center(
              child: Text("Offers"),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
            color: ThemeColors.secondaryColor,
          ));
        },
      ),
    );
  }
}
