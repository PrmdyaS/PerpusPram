import 'package:get/get.dart';

import '../controllers/all_page_controller.dart';

class AllPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPageController>(
      () => AllPageController(),
    );
  }
}
