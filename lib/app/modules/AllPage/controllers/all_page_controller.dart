import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AllPageController extends GetxController {
  RxInt index = 0.obs;
  RxInt currentPageIndex = 0.obs;
  RxInt currentNavIndex = 0.obs;
  var role = "".obs;
  String? login = Get.parameters['login'] ?? '';
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    bool rememberMe = StorageProvider.read(StorageKey.rememberMe) ?? false;
    if (login != "login") {
      if (!rememberMe) {
        StorageProvider.clearAll();
      }
    }
    // int? page = int.tryParse(Get.parameters['page'] ?? '');
    // if (page != null) {
    //   index.value = page;
    //   currentPageIndex.value = page;
    // } else {
    //   index.value = 0;
    //   currentPageIndex.value = 0;
    // }
    getData(0, 0, false);
  }

  @override
  void onReady() {
    super.onReady();
    // if ('${Get.parameters['open_page']}' == 'detailbuku') {
    //   Get.toNamed(Routes.DETAIL_BOOK, parameters: {
    //     'function': 'addToFavorite',
    //     'id': '${Get.parameters['id']}',
    //     'judul': '${Get.parameters['judul']}',
    //     'penulis': '${Get.parameters['penulis']}',
    //     'penerbit': '${Get.parameters['penerbit']}',
    //     'sampul_buku': '${Get.parameters['sampul_buku']}',
    //     'rating': '${Get.parameters['rating']}',
    //   });
    // }
    // else if ('${Get.parameters['open_page']}' == 'detailbukuQRCode') {
    //   Get.toNamed(Routes.DETAIL_BOOK, parameters: {
    //     'function': '${Get.parameters['function']}',
    //     'id_borrow_book': '${Get.parameters['id_borrow_book']}',
    //     'id': '${Get.parameters['id']}',
    //     'judul': '${Get.parameters['judul']}',
    //     'penulis': '${Get.parameters['penulis']}',
    //     'penerbit': '${Get.parameters['penerbit']}',
    //     'sampul_buku': '${Get.parameters['sampul_buku']}',
    //     'rating': '${Get.parameters['rating']}',
    //   });
    // }
    // else if ('${Get.parameters['open_page']}' == 'detailbukupinjam') {
    //   Get.toNamed(Routes.DETAIL_BOOK, parameters: {
    //     'function': 'pinjam',
    //     'id': '${Get.parameters['id']}',
    //     'judul': '${Get.parameters['judul']}',
    //     'penulis': '${Get.parameters['penulis']}',
    //     'penerbit': '${Get.parameters['penerbit']}',
    //     'sampul_buku': '${Get.parameters['sampul_buku']}',
    //     'rating': '${Get.parameters['rating']}',
    //   });
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }

  scanQR() async {
    try {
      var result = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (result != "-1") {
        Get.toNamed(Routes.SCAN, parameters: {"id": result});
      }
    } on PlatformException catch (e) {
      // Get.snackbar("Error", e.code);
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    }
  }

  getData(int pageIndex, int navIndex, bool refresh) {
    role.value = StorageProvider.read(StorageKey.role) ?? "";
    currentPageIndex.value = pageIndex;
    currentNavIndex.value = navIndex;
    if (refresh) {
      pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.ease,
      );
    }
  }
}
