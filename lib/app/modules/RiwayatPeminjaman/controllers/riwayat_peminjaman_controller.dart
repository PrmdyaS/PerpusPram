import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_borrow_book.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';

class RiwayatPeminjamanController extends GetxController {
  final loading = false.obs;
  var responseHistoryBorrowBook = <BorrowBook>[].obs;
  var id = "".obs;

  @override
  void onInit() {
    super.onInit();
    id.value = StorageProvider.read(StorageKey.idUser);
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    loading(true);
    try {
      final response = await ApiProvider.instance().get("${Endpoint.borrowBooks}/history/users/${id.value}");
      if (response.statusCode == 200) {
        final List<BorrowBook> responseData = (response.data['data'] as List)
            .map((json) => BorrowBook.fromJson(json))
            .toList();
        responseHistoryBorrowBook.assignAll(responseData);
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
          getData();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
