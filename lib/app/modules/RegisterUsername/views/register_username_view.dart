import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';

import '../controllers/register_username_controller.dart';

class RegisterUsernameView extends GetView<RegisterUsernameController> {
  RegisterUsernameView({Key? key}) : super(key: key);
  final FocusNode _usernameFocusNode = FocusNode();

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
                        "Pilih nama yang cocok untuk kamu!🩷",
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
                        "Ayo masukkan username!",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Obx(() => TextFormField(
                            controller: controller.usernameController,
                            autofocus: true,
                            focusNode: _usernameFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Masukkan username',
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
                                    color:
                                    Theme.of(context).colorScheme.secondary,
                                    width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Primary, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorText:
                              controller.errorTextUsername.value.isNotEmpty
                                  ? controller.errorTextUsername.value
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
                              if (value!.length < 1) {
                                return "Username tidak boleh kosong!";
                              }
                              return null;
                            },
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () {
                              controller.register();
                            },
                          ),),
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
                                onPressed: () => controller.register(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
