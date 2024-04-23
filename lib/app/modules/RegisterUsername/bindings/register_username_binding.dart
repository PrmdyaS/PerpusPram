import 'package:get/get.dart';

import '../controllers/register_username_controller.dart';

class RegisterUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterUsernameController>(
      () => RegisterUsernameController(),
    );
  }
}
