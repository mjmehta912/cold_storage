import 'package:get/get.dart';

class HomeBaseController extends GetxController {
  void navigateToScreen({
    required String page,
    dynamic arg,
  }) {
    if (arg != null) {
      Get.toNamed(
        page,
        arguments: arg,
      );
    } else {
      Get.toNamed(page);
    }
  }
}
