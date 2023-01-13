import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklifyap_mobil2/models/short_item_model.dart';

import '../../Base.dart';
import '../../models/item_model.dart';
import '../../style/colors.dart';
import '../initial/initial_screen.dart';

class InventoryController extends GetxController {
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

  Future<List<ShortItem>> get() => _getItems();

  Future<Item> getDetailed(int id) => _getDetailedItem(id);

  void updateItem(int id, String value) => _update(id, value);

  Future<List<ShortItem>> _getItems() async {
    final response =
        await http.get(Uri.parse("${Base.url}/api/v2/item"), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List<ShortItem> items =
          jsonDecode(utf8.decode(response.bodyBytes))['data']
              .map<ShortItem>((item) => ShortItem.fromJson(item))
              .toList();
      return items;
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }

  Future<Item> _getDetailedItem(int id) async {
    final response =
        await http.get(Uri.parse("${Base.url}/api/v2/item/$id"), headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      Item item =
          Item.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return item;
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }

  void _update(int id, String value) async {
    final response =
        await http.put(Uri.parse("${Base.url}/api/v2/item/$id"), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "value": value,
    });
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', "Value updated!",
          backgroundColor: ThemeColors.success);
    } else {
      Get.snackbar('Error', json.decode(response.body)['error'],
          backgroundColor: ThemeColors.error);
      throw Exception('Failed to load items');
    }
  }
}
