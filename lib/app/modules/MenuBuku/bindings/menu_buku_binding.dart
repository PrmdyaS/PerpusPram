import 'package:get/get.dart';

import '../controllers/menu_buku_controller.dart';

class MenuBukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuBukuController>(
      () => MenuBukuController(),
    );
  }
}
