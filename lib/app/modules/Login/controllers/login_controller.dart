import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/data/model/response_login.dart';
import 'package:dio/dio.dart' as dio;
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:perpus_pram/app/modules/AllPage/controllers/all_page_controller.dart';
import 'package:perpus_pram/app/modules/DetailBook/controllers/detail_book_controller.dart';
import 'package:perpus_pram/app/modules/Home/controllers/home_controller.dart';
import 'package:perpus_pram/app/modules/Profile/controllers/profile_controller.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';

class LoginController extends GetxController {
  LoginController({this.registerToPage, this.registerToId, this.registerToJudul, this.registerToPenulis, this.registerToPenerbit, this.registerToSampulBuku, this.registerToRating});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loading = false.obs;
  var isObscured = true.obs;
  var isChecked = true.obs;
  String? registerToPage, registerToId, registerToJudul, registerToPenulis, registerToPenerbit, registerToSampulBuku, registerToRating;
  String? page, id, judul, penulis, penerbit, sampulBuku, rating;
  var errorTextEmail = ''.obs;
  var errorTextPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    if (registerToPage != null) {
      page = registerToPage;
      id = registerToId;
      judul = registerToJudul;
      penulis = registerToPenulis;
      penerbit = registerToPenerbit;
      sampulBuku = registerToSampulBuku;
      rating = registerToRating;
    } else {
      page = Get.parameters['page'];
      id = '${Get.parameters['id']}';
      judul = '${Get.parameters['judul']}';
      penulis = '${Get.parameters['penulis']}';
      penerbit = '${Get.parameters['penerbit']}';
      sampulBuku = '${Get.parameters['sampul_buku']}';
      rating = '${Get.parameters['rating']}';
    }
    String status = StorageProvider.read(StorageKey.status) ?? "";
    if (status == 'logged') {
      Get.back();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login, data: {
          "email": emailController.text,
          "password": passwordController.text,
        });
        loginNext2(response, false);
      }
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          if ("${e.response?.data['message']}" == "Email tidak ditemukan") {
            errorTextEmail.value = "${e.response?.data['message']}";
          } else if ("${e.response?.data['message']}" ==
              "Password tidak cocok") {
            errorTextPassword.value = "${e.response?.data['message']}";
          }
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  loginNext(String email, String password, bool register) async {
    final response = await ApiProvider.instance().post(Endpoint.login, data: {
      "email": email,
      "password": password,
    });
    bool login = await loginNext2(response, register);
    if (login) {
      return true;
    }
  }

  loginNext2(dynamic response, bool register) async {
    if (response.statusCode == 200) {
      if (isChecked.value == true) {
        await StorageProvider.write(StorageKey.status, "logged");
        await StorageProvider.writeBool(StorageKey.rememberMe, true);
      } else {
        await StorageProvider.write(StorageKey.status, "logged");
        await StorageProvider.writeBool(StorageKey.rememberMe, false);
      }
      final ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
      await StorageProvider.write(
          StorageKey.idUser, responseLogin.data!.id!.toString());
      await StorageProvider.write(
          StorageKey.username, responseLogin.data!.username!.toString());
      await StorageProvider.write(
          StorageKey.role, responseLogin.data!.indexLevelRoles!.toString());
      await StorageProvider.write(
          StorageKey.profilePicture, responseLogin.data!.profilePicture!.toString());
      loading(false);
      if (page == 'favoritsaya') {
        String id = responseLogin.data!.id!.toString();
        Get.offAndToNamed(Routes.LIST_BOOK, parameters: {
          'title': 'Favorit Saya',
          'endpoint': '${Endpoint.favoriteSaya}/$id'
        });
      } else if (page == 'detailbuku') {
        final previousDetailBookController = Get.find<DetailBookController>();
        previousDetailBookController.getStorageData();
        previousDetailBookController.addToFavorite();
        final previousProfileController = Get.find<ProfileController>();
        previousProfileController.getData();
        final previousAllPageController = Get.find<AllPageController>();
        previousAllPageController.getData(0, 0, true);
        if (register) {
          return true;
        } else {
          Get.back(closeOverlays: true);
        }
      } else if (page == 'detailbukupinjam') {
        final previousDetailBookController = Get.find<DetailBookController>();
        previousDetailBookController.getStorageData();
        previousDetailBookController.getDataFavorite();
        previousDetailBookController.isDateShowed(true);
        previousDetailBookController.showBottomNavBar(false);
        final previousProfileController = Get.find<ProfileController>();
        previousProfileController.getData();
        final previousAllPageController = Get.find<AllPageController>();
        previousAllPageController.getData(0, 0, true);
        if (register) {
          return true;
        } else {
          Get.back(closeOverlays: true);
        }
      } else {
        final previousHomeController = Get.find<HomeController>();
        previousHomeController.getRole();
        final previousProfileController = Get.find<ProfileController>();
        previousProfileController.getData();
        final previousAllPageController = Get.find<AllPageController>();
        previousAllPageController.getData(3, 3, true);
        if (register) {
          return true;
        } else {
          Get.back(closeOverlays: true);
        }
      }
      return true;
    } else {
      Get.snackbar("Sorry", "Login Gagal", backgroundColor: Colors.orange);
    }
  }
}
