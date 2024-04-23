import 'package:get/get.dart';

import '../controllers/riwayat_peminjaman_controller.dart';

class RiwayatPeminjamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPeminjamanController>(
      () => RiwayatPeminjamanController(),
    );
  }
}
