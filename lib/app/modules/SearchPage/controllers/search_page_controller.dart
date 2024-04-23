import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/data/model/response_query.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

class SearchPageController extends GetxController {
  final TextEditingController queryController = TextEditingController();
  final loading = false.obs;
  final search = false.obs;
  final searchData = false.obs;
  var query = "".obs;
  late ResponseQuery responseQuery;
  var responseBook = <DataBook>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSearch("");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSearch(String q) async {
    if (q != "") {
      loading(true);
      search(true);
      searchData(false);
      try {
        final response = await ApiProvider.instance().get("${Endpoint.searchBooks}?q=${q}");
        if (response.statusCode == 200) {
          responseQuery = ResponseQuery.fromJson(response.data);
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
          }
        } else {
          Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
        }
      } catch (e) {
        loading(false);
        Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
        print(e.toString());
      }
    }
  }

  getData(String q) async {
    loading(true);
    searchData(true);
    try {
      final response = await ApiProvider.instance().get("${Endpoint.searchDataBooks}?q=${q}");
      if (response.statusCode == 200) {
        final List<DataBook> responseData = (response.data['data'] as List)
            .map((json) => DataBook.fromJson(json))
            .toList();
        responseBook.assignAll(responseData);
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
