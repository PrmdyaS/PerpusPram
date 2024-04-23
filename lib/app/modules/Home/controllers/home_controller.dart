import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/model/response_sub_categories.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController {
  var subCategoriesList = <DataSubCategories>[].obs;
  var rekomendasiBookList = <DataBook>[].obs;
  var terbaruBookList = <DataBook>[].obs;
  var ratingTertinggiBookList = <DataBook>[].obs;
  final loading = false.obs;
  final endpointRekomendasi = Endpoint.allBooks;
  final endpointTerbaru = Endpoint.terbaru;
  final endpointRatingTertinggi = Endpoint.ratingTertinggi;
  final endpointSubCategories = Endpoint.subCategories;
  var role = "".obs;

  @override
  void onInit() {
    super.onInit();
    getRole();
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

  getRole() async {
    role.value = StorageProvider.read(StorageKey.role) ?? "";
  }

  getData() async {
    loading(true);
    try {
      final responseSubCategories = await ApiProvider.instance().get(endpointSubCategories);
      final responseRekomendasi = await ApiProvider.instance().get(endpointRekomendasi);
      final responseTerbaru = await ApiProvider.instance().get(endpointTerbaru);
      final responseRatingTertinggi = await ApiProvider.instance().get(endpointRatingTertinggi);
      if (responseSubCategories.statusCode == 200 && responseRekomendasi.statusCode == 200 && responseTerbaru.statusCode == 200 && responseRatingTertinggi.statusCode == 200) {
        final List<DataSubCategories> subCategories = (responseSubCategories.data['data'] as List)
            .map((json) => DataSubCategories.fromJson(json))
            .toList();
        final List<DataBook> booksRekomendasi = (responseRekomendasi.data['data'] as List)
            .map((json) => DataBook.fromJson(json))
            .toList();
        final List<DataBook> booksTerbaru = (responseTerbaru.data['data'] as List)
            .map((json) => DataBook.fromJson(json))
            .toList();
        final List<DataBook> booksRatingTertinggi = (responseRatingTertinggi.data['data'] as List)
            .map((json) => DataBook.fromJson(json))
            .toList();
        subCategoriesList.assignAll(subCategories);
        rekomendasiBookList.assignAll(booksRekomendasi);
        terbaruBookList.assignAll(booksTerbaru);
        ratingTertinggiBookList.assignAll(booksRatingTertinggi);
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getData();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
