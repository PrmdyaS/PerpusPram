import 'package:get/get.dart';

import '../controllers/laporan_peminjaman_controller.dart';

class LaporanPeminjamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanPeminjamanController>(
      () => LaporanPeminjamanController(),
    );
  }
}
