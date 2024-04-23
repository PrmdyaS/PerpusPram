import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/modules/AllPage/controllers/all_page_controller.dart';
import 'package:perpus_pram/app/modules/Profile/controllers/profile_controller.dart';

class ListBookController extends GetxController {
  var responseBook = <DataBook>[].obs;
  final loading = false.obs;
  final endpoint = Get.parameters['endpoint'];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    if (Get.parameters['title'] == 'Favorit Saya') {
      final previousProfileController = Get.find<ProfileController>();
      previousProfileController.getData();
      final previousAllPageController = Get.find<AllPageController>();
      previousAllPageController.getData(3, 3, true);
    }
  }

  getData() async {
    loading(true);
    try {
      if (Get.parameters['title'] == 'Favorit Saya') {
        responseBook.clear();
        final response = await ApiProvider.instance().get('$endpoint');
        if (response.statusCode == 200) {
          final responseData = response.data;
          if (responseData.containsKey('data')) {
            final List<dynamic> favoritesData = responseData['data'];
            favoritesData.forEach((favoriteData) {
              if (favoriteData['books'] != null) {
                final Map<String, dynamic> bookData = favoriteData['books'];
                responseBook.add(DataBook.fromJson(bookData));
              }
            });
          } else {
            Get.snackbar("Sorry", "Data buku tidak ditemukan",
                backgroundColor: Colors.orange);
          }
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
      } else {
        final response = await ApiProvider.instance().get('${endpoint}');
        if (response.statusCode == 200) {
          final List<DataBook> responseData = (response.data['data'] as List)
              .map((json) => DataBook.fromJson(json))
              .toList();
          responseBook.assignAll(responseData);
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
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
      print(e.toString());
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
