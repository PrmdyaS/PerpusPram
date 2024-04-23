import 'package:get/get.dart';

import '../controllers/laporan_denda_controller.dart';

class LaporanDendaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanDendaController>(
      () => LaporanDendaController(),
    );
  }
}
