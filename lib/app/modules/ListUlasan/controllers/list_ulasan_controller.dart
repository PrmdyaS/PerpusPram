import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

class ListUlasanController extends GetxController {
  final listUlasan = <dynamic>[].obs;
  var expandedReview = false.obs;
  final loadingUlasan = false.obs;


  @override
  void onInit() {
    super.onInit();
    getDataUlasan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDataUlasan() async {
    loadingUlasan(true);
    try {
      final response = await ApiProvider.instance()
          .get('${Endpoint.reviews}books/${Get.arguments['id']}');
      if (response.statusCode == 200) {
        listUlasan.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Ulasan Buku",
            backgroundColor: Colors.orange);
      }
      loadingUlasan(false);
    } on DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUlasan(false);
      print(e.toString());
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
