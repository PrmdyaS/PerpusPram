import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:perpus_pram/app/modules/Login/controllers/login_controller.dart';

class RegisterUsernameController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final loading = false.obs;
  var email;
  var password;
  String? page = Get.parameters['page'];
  var errorTextUsername = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final Map args = Get.arguments;
    email = args['email'];
    password = args['password'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  register() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response =
            await ApiProvider.instance().post(Endpoint.register, data: {
          "email": email.toString(),
          "password": password.toString(),
          "username": usernameController.text.toString(),
          "nama_lengkap": "",
          "alamat": "",
          "no_hp": "",
          "index_level_roles": "1",
          "profile_picture": "",
        });
        if (response.statusCode == 200) {
          final LoginController loginController = Get.put(LoginController(
              registerToPage: page,
              registerToId: '${Get.parameters['id']}',
              registerToJudul: '${Get.parameters['judul']}',
              registerToPenulis: '${Get.parameters['penulis']}',
              registerToPenerbit: '${Get.parameters['penerbit']}',
              registerToSampulBuku: '${Get.parameters['sampul_buku']}',
              registerToRating: '${Get.parameters['rating']}'));
          bool login = await loginController.loginNext(email.toString(), password.toString(), true);
          if (login) {
            Get.back(closeOverlays: true);
            Get.back(closeOverlays: true);
          }
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          errorTextUsername.value = "${e.response?.data['message']}";
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
