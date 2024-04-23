import 'package:get/get.dart';

import '../controllers/list_book_controller.dart';

class ListBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListBookController>(
      () => ListBookController(),
    );
  }
}
