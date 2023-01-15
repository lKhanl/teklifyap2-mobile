import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/layout/custom_button.dart';
import 'package:teklifyap_mobil2/layout/custom_text_field.dart';
import 'package:teklifyap_mobil2/screens/offer/offer_screen.dart';

import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../style/colors.dart';
import 'make_offer_controller.dart';

class MakeOfferScreen extends StatefulWidget {
  const MakeOfferScreen({super.key});

  @override
  State<MakeOfferScreen> createState() => _MakeOfferScreenState();
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final MakeOfferController _controller = Get.put(MakeOfferController());

  TextEditingController titleController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController profitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: const CustomAppBar(title: "Make Offer"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.profile),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              placeholder: 'Title',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: receiverController,
              placeholder: 'Receiver',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: usernameController,
              placeholder: 'Username',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: profitController,
              placeholder: 'Profit',
            ),
            const SizedBox(height: 16),
            CustomButton(
              backgroundColor: ThemeColors.secondaryColor,
              onPressed: () {
                Get.snackbar("title", "message");
              },
              title: 'Add Item',
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                Get.snackbar(titleController.text, receiverController.text);
                Get.offAll(() => const OfferScreen());
              },
              title: 'Make Offer',
            ),
          ],
        ),
      ),
    );
  }
}
