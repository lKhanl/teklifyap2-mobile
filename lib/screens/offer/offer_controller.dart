import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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


}
