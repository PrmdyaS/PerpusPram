import 'package:get/get.dart';

import '../controllers/list_ulasan_controller.dart';

class ListUlasanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListUlasanController>(
      () => ListUlasanController(),
    );
  }
}
