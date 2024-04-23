import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';

class ScanController extends GetxController {
  final loading = false.obs;
  final dataBorrowBook = {}.obs;
  var title = "".obs;
  var msg = "".obs;
  var alertDialog = "".obs;
  var isVisible = false.obs;
  var loadingDenda = false.obs;
  var errorBuktiPembayaran = false.obs;
  var errorPaymentMethod = false.obs;
  var selectedItem = ''.obs;
  var status = ''.obs;
  var id = ''.obs;
  var userId = ''.obs;
  var selectedImages = Rx<File?>(null);
  File? get selectedImage => selectedImages.value;

  @override
  void onInit() {
    super.onInit();
    userId.value = StorageProvider.read(StorageKey.idUser);
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
      final idRegex = RegExp(r'^[a-z0-9]{24}$');
      if (idRegex.hasMatch("${Get.parameters['id']}")) {
        final response = await ApiProvider.instance()
            .get("${Endpoint.borrowBooks}/${Get.parameters['id']}");
        if (response.statusCode == 200) {
          dataBorrowBook.value = response.data['data'];
          status.value = response.data['data']['status'];
          id.value = response.data['data']['_id'];
          if (status.value == "Menunggu Verifikasi") {
            title.value = "Pinjam Buku";
          } else if (status.value == "Dipinjam" || status.value == "Denda") {
            title.value = "Kembalikan Buku";
          }
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
      } else {
        msg.value = "QR CODE TIDAK VALID";
      }

      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          msg.value = e.response?.data['message'];
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

  terimaFunction() async {
    loading(true);
    try {
      if (status.value == "Menunggu Verifikasi") {
        final response = await ApiProvider.instance()
            .patch("${Endpoint.borrowBooks}/${id}", data: {
          "status": "Dipinjam",
        });
        if (response.statusCode == 200) {
          alertDialog.value = 'Verfikasi buku berhasil!';
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
      } else if (status.value == "Dipinjam") {
        final response = await ApiProvider.instance()
            .patch("${Endpoint.borrowBooks}/${id}", data: {
          "status": "Tepat Waktu",
        });
        if (response.statusCode == 200) {
          alertDialog.value = 'Kembalikan buku berhasil!';
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
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

  tolakFunction() async {
    loading(true);
    try {
      if (status.value == "Menunggu Verifikasi") {
        final response = await ApiProvider.instance()
            .patch("${Endpoint.borrowBooks}/${id}", data: {
          "status": "Dibatalkan",
        });
        if (response.statusCode == 200) {
          alertDialog.value = 'Tolak buku berhasil!';
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
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

  lunasiDenda() async {
    loading(true);
    try {
      if (status.value == "Denda") {
        if (selectedItem.value != '' && selectedImages.value != null) {
          dio.FormData formData = dio.FormData.fromMap({
            "payment_method": selectedItem.value,
            "user_id_officer": userId.value,
          });
          if (selectedImage != null) {
            formData.files.add(MapEntry(
              'bukti_pembayaran',
              await dio.MultipartFile.fromFile(
                selectedImage!.path,
                filename: "image.jpg",
              ),
            ));
          }
          final responseDenda = await ApiProvider.instance().post(
            Endpoint.denda,
            data: formData,
          );
          final response = await ApiProvider.instance()
              .patch("${Endpoint.borrowBooks}/$id", data: {
            "status": "Denda Lunas",
            "denda_id": responseDenda.data['data']['insertedId'],
          });
          if (response.statusCode == 200) {
            if (responseDenda.statusCode == 200) {
              isVisible(false);
              alertDialog.value = 'Pelunasan buku berhasil!';
            }
          } else {
            Get.snackbar("Sorry", "Gagal Memuat Buku",
                backgroundColor: Colors.orange);
          }
        } else {
          if (selectedImages.value == null) {
            errorBuktiPembayaran(true);
          }
          if (selectedItem.value == '') {
            errorPaymentMethod(true);
          }
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
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

  Future<void> pickImage() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      selectedImages.value = File(returnImage.path);
    }
  }
}
