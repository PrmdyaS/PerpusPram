import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:perpus_pram/app/modules/Profile/controllers/profile_controller.dart';

class EditProfileController extends GetxController {
  final loading = false.obs;
  final loadingUpdate = false.obs;
  final ppShowed = false.obs;
  final usernameAvailable = ''.obs;
  final idUser = ''.obs;
  final selectUser = {}.obs;
  final updates = false.obs;
  var initialUsername = ''.obs;
  var errorTextUsername = ''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  var imagePath = ''.obs;
  var selectedImages = Rx<File?>(null);
  var images = Rx<File?>(null);

  File? get selectedImage => selectedImages.value;

  File? get image => images.value;

  @override
  void onInit() {
    super.onInit();
    idUser.value = StorageProvider.read(StorageKey.idUser);
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    if (updates.value == true) {
      final previousPageController = Get.find<ProfileController>();
      previousPageController.getData();
    }
  }

  checkUsername(String value) async {
    usernameAvailable.value = '0';
    try {
      final response =
          await ApiProvider.instance().get(Endpoint.checkUsername, data: {
        "username": value,
      });
      if (response.statusCode == 200) {
        usernameAvailable.value = '1';
        errorTextUsername.value = '';
      }
    } on dio.DioException catch (e) {
      usernameAvailable.value = '0';
      if (e.response != null) {
        if (e.response?.data != null) {
          if (initialUsername.value != usernameController.text) {
            usernameAvailable.value = '2';
            errorTextUsername.value = e.response?.data['message'];
          } else if (initialUsername.value == usernameController.text) {
            usernameAvailable.value = '';
            errorTextUsername.value = '';
          }
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      usernameAvailable.value = '0';
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getData() async {
    loading(true);
    try {
      final response =
          await ApiProvider.instance().get("${Endpoint.user}/${idUser.value}");
      if (response.statusCode == 200) {
        selectUser.value = response.data['data'];
        initialUsername.value = selectUser.value['username'];
        usernameController.text = selectUser.value['username'];
        namaLengkapController.text = selectUser.value['nama_lengkap'];
        alamatController.text = selectUser.value['alamat'];
        noHpController.text = selectUser.value['no_hp'];
        imagePath.value = selectUser.value['profile_picture'];
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "Koneksi Anda Lag",
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

  Future<void> pickImage() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      images.value = File(returnImage.path);
      cropImage();
    }
  }

  Future<void> cropImage() async {
    if (images.value != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: images.value!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            activeControlsWidgetColor: Primary,
            toolbarTitle: 'Pangkas Foto',
            toolbarColor: Primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );
      if (croppedFile != null) {
        selectedImages.value = File(croppedFile.path);
      }
    }
  }

  updateUser() async {
    loadingUpdate(true);
    updates(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        dio.FormData formData = dio.FormData.fromMap({
          "username": usernameController.text.toString(),
          "nama_lengkap": namaLengkapController.text.toString(),
          "alamat": alamatController.text.toString(),
          "no_hp": noHpController.text.toString(),
        });
        if (selectedImage != null) {
          if (selectedImage != null) {
            formData.files.add(MapEntry(
              'profile_picture',
              await dio.MultipartFile.fromFile(
                selectedImage!.path,
                filename: "image.jpg",
              ),
            ));
          }
        }
        final response = await ApiProvider.instance().patch(
          "${Endpoint.user}/${idUser.value}",
          data: formData,
        );
        if (response.statusCode == 200) {
          Get.snackbar("Berhasil", "Update Berhasil",
              backgroundColor: Colors.greenAccent);
          await StorageProvider.write(StorageKey.profilePicture,
              response.data['data']['profile_picture']);
          await StorageProvider.write(
              StorageKey.username, usernameController.text.toString());
        } else {
          Get.snackbar("Sorry", "Update failed",
              backgroundColor: Colors.orange);
        }
      }
      loadingUpdate(false);
    } on dio.DioError catch (e) {
      loadingUpdate(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Error", "${e.response}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Error", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUpdate(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      loadingUpdate(false);
    }
  }
}
