import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmasiPasswordController =
      TextEditingController();
  final loading = false.obs;
  var isObscured = true.obs;
  var isObscured2 = true.obs;
  var isChecked = true.obs;
  var password = RxString('');
  var errorTextEmail = ''.obs;

  void updatePassword(String newValue) {
    password.value = newValue;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  cekRegister() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response =
            await ApiProvider.instance().post(Endpoint.register, data: {
          "email": emailController.text.toString(),
          "username": "",
        });
        if (response.statusCode == 201) {
          Get.toNamed(Routes.REGISTER_USERNAME, arguments: {
            'email': emailController.text.toString(),
            'password': passwordController.text.toString()
          }, parameters: {
            'page': '${Get.parameters['page']}',
            'id': '${Get.parameters['id']}',
            'judul': '${Get.parameters['judul']}',
            'penulis': '${Get.parameters['penulis']}',
            'penerbit': '${Get.parameters['penerbit']}',
            'sampul_buku': '${Get.parameters['sampul_buku']}',
            'rating': '${Get.parameters['rating']}',
          });
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          errorTextEmail.value = "${e.response?.data['message']}";
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
