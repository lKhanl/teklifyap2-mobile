import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/models/short_item_model.dart';
import '../../Base.dart';
import '../../models/offer_model.dart';
import '../../models/short_offer.dart';
import '../../style/colors.dart';
import '../initial/initial_screen.dart';

class OfferController extends GetxController {
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

  Future<List<ShortOffer>> get() => _getOffers();

  Future<Offer> getDetailed(int id) => _getDetailedOffer(id);

  void updateOffer(int id, String title, bool status, String userName,
      String receiverName, double profitRate) =>
      _update(id,title,userName,receiverName,profitRate);

  void deleteOffer(int id) => _delete(id);

  void changeOfferStatus(int id) => _changeStatus(id);

  Future<Offer> _getDetailedOffer(int id) async {
    final response =
    await http.get(Uri.parse("${Base.url}/api/v2/offer/$id"), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Offer offer = Offer.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return offer;
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }

  Future<List<ShortOffer>> _getOffers() async {
    final response =
    await http.get(Uri.parse("${Base.url}/api/v2/offer"), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List<ShortOffer> items =
      jsonDecode(utf8.decode(response.bodyBytes))['data']
          .map<ShortOffer>((item) => ShortOffer.fromJson(item))
          .toList();
      return items;
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }

  void _update(int id, String title, String userName,
      String receiverName, double profitRate) async {
    final response = await http.put(Uri.parse("${Base.url}/api/v2/offer/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": title,
          "userName": userName,
          "receiverName": receiverName,
          "profitRate": profitRate,
        }));
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', "Value updated!",
          backgroundColor: ThemeColors.success);
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load offers');
    }
  }

  void _changeStatus(int id) async {
    final response = await http.put(Uri.parse("${Base.url}/api/v2/offer/status/$id"),
        headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', "Offer status successfully changed!",
          backgroundColor: ThemeColors.success);
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load offers');
    }
  }

  void _delete(int id) async {
    final response =
    await http.delete(Uri.parse("${Base.url}/api/v2/offer/$id"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', "Item deleted!",
          backgroundColor: ThemeColors.success);
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load offers');
    }
  }



}
