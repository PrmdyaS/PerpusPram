import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/modules/DetailBook/controllers/detail_book_controller.dart';
import 'package:perpus_pram/app/modules/RiwayatPeminjaman/controllers/riwayat_peminjaman_controller.dart';

class ReviewController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ulasanController = TextEditingController();
  var rating = 0.obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['rating'] != null) {
      rating.value = int.parse(Get.arguments['rating']);
      ulasanController.text = Get.arguments['review_text'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  postReview() async {
    loading(true);
    try {
      final response =
          await ApiProvider.instance().post(Endpoint.reviews, data: {
        "borrow_books_id": Get.arguments['borrow_books_id'],
        "rating": rating.value,
        "review_text": ulasanController.text,
      });
      final responsePeminjaman =
      await ApiProvider.instance().patch('${Endpoint.borrowBooks}/${Get.arguments['borrow_books_id']}', data: {
        "review": 1,
      });
      if (response.statusCode == 200 && responsePeminjaman.statusCode == 200) {
        final previousPageController = Get.find<RiwayatPeminjamanController>();
        previousPageController.getData();
        Get.back(closeOverlays: true);
        Fluttertoast.showToast(
          msg: "Berhasil memberikan ulasan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Primary,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Get.snackbar("Sorry", "Beri Ulasan Buku Gagal",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  updateReview() async {
    loading(true);
    try {
      final response =
      await ApiProvider.instance().patch('${Endpoint.reviews}${Get.arguments['id']}', data: {
        "rating": rating.value,
        "review_text": ulasanController.text,
      });
      if (response.statusCode == 200) {
        final previousPageController = Get.find<DetailBookController>();
        previousPageController.getDataUlasanAnda(Get.arguments['user_id'], Get.arguments['book_id']);
        Get.back(closeOverlays: true);
        Fluttertoast.showToast(
          msg: "Update ulasan berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Primary,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Get.snackbar("Sorry", "Beri Ulasan Buku Gagal",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
