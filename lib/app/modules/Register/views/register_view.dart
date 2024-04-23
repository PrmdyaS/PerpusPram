import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _konfirmasiPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "DAFTAR",
          style: GoogleFonts.getFont(
            'Roboto',
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Hai, Selamat Datang!👋",
                        style: GoogleFonts.getFont(
                          'Roboto',
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Ayo buat akun untukmu!",
                        style: GoogleFonts.getFont(
                          'Roboto',
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Obx(
                            () => TextFormField(
                              controller: controller.emailController,
                              autofocus: true,
                              focusNode: _emailFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Masukkan email address',
                                hintStyle: GoogleFonts.getFont('Roboto',
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.8))),
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Primary, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorText:
                                    controller.errorTextEmail.value.isNotEmpty
                                        ? controller.errorTextEmail.value
                                        : null,
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                final emailRegex = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                                if (value!.length < 1) {
                                  return "Email tidak boleh kosong!";
                                } else if (!emailRegex.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onEditingComplete: () {
                                _emailFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Obx(
                            () => TextFormField(
                              controller: controller.passwordController,
                              obscureText: controller.isObscured.value,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Masukkan password',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8)),
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Primary, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Obx(
                                      () => Icon(controller.isObscured.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    onPressed: () => controller.isObscured
                                        .value = !controller.isObscured.value,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length < 1) {
                                  return "Password tidak boleh kosong!";
                                } else if (value!.length < 6) {
                                  return "Password tidak boleh kurang dari 6 digit!";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onEditingComplete: () {
                                _passwordFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_konfirmasiPasswordFocusNode);
                              },
                              onChanged: (value) {
                                controller.updatePassword(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Konfirmasi Password",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Obx(
                            () => TextFormField(
                              controller:
                                  controller.konfirmasiPasswordController,
                              obscureText: controller.isObscured2.value,
                              focusNode: _konfirmasiPasswordFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Masukkan konfirmasi password',
                                hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Primary, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Obx(
                                      () => Icon(controller.isObscured2.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    onPressed: () => controller.isObscured2
                                        .value = !controller.isObscured2.value,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length < 1) {
                                  return "Password tidak boleh kosong!";
                                } else if (value!.length < 6) {
                                  return "Password tidak boleh kurang dari 6 digit!";
                                } else if (value.toString() !=
                                    controller.password.toString()) {
                                  return "Password tidak cocok!";
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onEditingComplete: () {
                                controller.cekRegister();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.loading.value
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => controller.cekRegister(),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ).copyWith(
                                  backgroundColor:
                                  MaterialStateProperty.all(Primary),
                                ),
                                child: Text(
                                  "DAFTAR",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Text(
                              "Sudah punya akun?",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.offAndToNamed(Routes.LOGIN),
                            child: Text(
                              "Masuk",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 50,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Atau Daftar dengan",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 50,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image(
                                image: AssetImage(
                                    'lib/app/assets/image/google.png'),
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dengan mendaftar, anda menyetujui",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Terms of Service",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Primary,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  "dan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              Text(
                                "Privacy Police",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Primary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
