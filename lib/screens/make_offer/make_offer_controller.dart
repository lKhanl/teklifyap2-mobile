import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/screens/offer/offer_screen.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

import '../../Base.dart';
import '../../models/make_offer.dart';
import '../../models/make_offer_item.dart';
import '../initial/initial_screen.dart';

class MakeOfferController extends GetxController {
  late String token;

  @override
  void onInit() async {
    super.onInit();
    token = GetStorage().read('token');
    if (token == "") {
      GetStorage().write('token', '');
      Get.offAll(() => const InitialScreen());
    }
  }

  void makeOffer(List<MakeOfferItem> items, MakeOffer offer) =>
      _makeOffer(items, offer);

  Future<void> _makeOffer(List<MakeOfferItem> items, MakeOffer offer) async {
    final response = await http.post(Uri.parse("${Base.url}/api/v2/offer"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": offer.title,
          "receiverName": offer.receiverName,
          "userName": offer.userName,
          "profitRate": "1.${offer.profitRate}",
          "items": items.map((e) => e.toJson()).toList(),
        }));
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', "Offer is made successfully",
          backgroundColor: ThemeColors.success);
      Get.offAll(() => const OfferScreen());
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }
}
