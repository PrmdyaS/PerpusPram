import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "MASUK",
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
                        "Hai, Selamat Datang Kembali!👋",
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
                        "Senang bertemu anda lagi, silahkan login.",
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
                                errorText: controller.errorTextEmail.value.isNotEmpty
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
                                errorText: controller.errorTextPassword.value.isNotEmpty
                                    ? controller.errorTextPassword.value
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
                                controller.login();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.isChecked.value =
                                  !controller.isChecked.value;
                            },
                            child: Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    activeColor: Primary,
                                    checkColor: Colors.white,
                                    value: controller.isChecked.value,
                                    onChanged: (value) {
                                      controller.isChecked.value =
                                          !controller.isChecked.value;
                                    },
                                  ),
                                ),
                                Text(
                                  "Ingat Saya",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: controller.isChecked.value
                                          ? Primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("lupa password clicked");
                          },
                          child: Text(
                            "Lupa Password",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                onPressed: () => controller.login(),
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
                                  "MASUK",
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
                              "Tidak punya akun?",
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
                            onTap: () => Get.offAndToNamed(Routes.REGISTER,
                                parameters: {
                                  'page': '${Get.parameters['page']}',
                                  'id': '${Get.parameters['id']}',
                                  'judul': '${Get.parameters['judul']}',
                                  'penulis': '${Get.parameters['penulis']}',
                                  'penerbit': '${Get.parameters['penerbit']}',
                                  'sampul_buku': '${Get.parameters['sampul_buku']}',
                                  'rating': '${Get.parameters['rating']}',
                                }),
                            child: Text(
                              "Daftar",
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
                              "Atau Masuk dengan",
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
                    margin: EdgeInsets.only(bottom: 20),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
