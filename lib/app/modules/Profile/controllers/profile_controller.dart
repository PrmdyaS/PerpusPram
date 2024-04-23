import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  var status = "".obs;
  var username = "".obs;
  var profilePicture = "".obs;
  var id = "".obs;
  final isVisible = false.obs;
  var endpointFavoritSaya = ''.obs;
  final loading = false.obs;

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
  }

  getData() async {
    loading(true);
    try {
      username.value = StorageProvider.read(StorageKey.username);
      profilePicture.value = StorageProvider.read(StorageKey.profilePicture);
      id.value = StorageProvider.read(StorageKey.idUser);
      status.value = StorageProvider.read(StorageKey.status);
      endpointFavoritSaya.value = '${Endpoint.favoriteSaya}/${id}';
      if (status.value == 'logged') {
        isVisible(true);
      } else {
        isVisible(false);
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
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  logout() {
    StorageProvider.clearAll();
    Get.offAllNamed(Routes.ALL_PAGE);
  }
}
