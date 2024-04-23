import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_login.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

class ManagementUserController extends GetxController {
  final loading = false.obs;
  final loadingRoles = false.obs;
  final loadingUpdate = false.obs;
  var usersList = <DataLogin>[].obs;
  final rolesList = <dynamic>[].obs;
  final updateList = <dynamic>[].obs;
  var selectAlert = ''.obs;
  var msg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    getDataRoles();
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
      final response = await ApiProvider.instance().get(Endpoint.listUsers);
      if (response.statusCode == 200) {
        final List<DataLogin> books = (response.data['data'] as List)
            .map((json) => DataLogin.fromJson(json))
            .toList();
        usersList.assignAll(books);
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

  getDataRoles() async {
    loadingRoles(true);
    try {
      final response = await ApiProvider.instance().get(Endpoint.roles);
      if (response.statusCode == 200) {
        rolesList.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loadingRoles(false);
    } on DioException catch (e) {
      loadingRoles(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
          getDataRoles();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingRoles(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  updateRoles() async {
    loadingUpdate(true);
    try {
      final response = await ApiProvider.instance().patch(Endpoint.updateRoleUsers, data: {
        "updates": updateList.value,
      });
      if (response.statusCode == 200) {
        selectAlert.value = 'success';
        msg.value = 'Update buku berhasil!';
        updateList.value = [];
        getData();
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loadingUpdate(false);
    } on DioException catch (e) {
      loadingUpdate(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
          selectAlert.value = 'danger';
          msg.value = 'Gagal update buku!';
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUpdate(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
