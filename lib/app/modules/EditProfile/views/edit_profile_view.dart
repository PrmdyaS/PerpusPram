import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 40),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () => controller.ppShowed(true),
                                  child: Obx(() {
                                    if (controller.selectedImage != null) {
                                      return CircleAvatar(
                                        radius: 60,
                                        backgroundImage: Image.file(
                                                controller.selectedImage!)
                                            .image,
                                      );
                                    } else if (controller
                                        .imagePath.value.isNotEmpty) {
                                      return CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                            controller.imagePath.value),
                                      );
                                    } else {
                                      return SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 120,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      );
                                    }
                                  }),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  top: 85,
                                  child: GestureDetector(
                                    onTap: () => controller.pickImage(),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Primary,
                                      ),
                                      child: Icon(
                                        Icons.create,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: TextFormField(
                                controller: controller.usernameController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                  ),
                                  hintText: 'Masukkan Username',
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
                                  errorText:
                                      controller.errorTextUsername.value.isNotEmpty
                                          ? controller.errorTextUsername.value
                                          : null,
                                  suffixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, bottom: 5),
                                      child: Obx(() {
                                        if (controller
                                                .usernameAvailable.value ==
                                            '1') {
                                          return const Icon(Icons.check,
                                              size: 25);
                                        } else if (controller
                                                .usernameAvailable.value ==
                                            '2') {
                                          return const Icon(Icons.clear,
                                              size: 25);
                                        } else if (controller
                                                .usernameAvailable.value ==
                                            '0') {
                                          return const SizedBox(
                                              width: 0,
                                              height: 0,
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return const SizedBox(
                                              width: 0, height: 0);
                                        }
                                      })),
                                ),
                                onChanged: (value) =>
                                    controller.checkUsername(value),
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return "Username tidak boleh kosong!";
                                  } else if (controller.errorTextUsername.value != '') {
                                    return controller.errorTextUsername.value;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: TextFormField(
                                controller: controller.namaLengkapController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: 'Nama Lengkap',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  hintText: 'Masukkan Nama Lengkap',
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
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: TextFormField(
                                controller: controller.alamatController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: 'Alamat',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  hintText: 'Masukkan Alamat',
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
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: TextFormField(
                                controller: controller.noHpController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: 'Nomor Hp',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  hintText: 'Masukkan Nomor Hp',
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
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: ElevatedButton(
                                onPressed: () => controller.updateUser(),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ).copyWith(
                                  backgroundColor:
                                  MaterialStateProperty.all(Primary),
                                ),
                                child: Obx(
                                  () => controller.loadingUpdate.value
                                      ? Container(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          "SIMPAN",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            color: Colors.white
                                          ),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() => AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: controller.ppShowed.value ? 1.0 : 0.0,
                      child: controller.ppShowed.value
                          ? GestureDetector(
                              onTap: () {
                                controller.ppShowed(false);
                              },
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Obx(() {
                                            if (controller.selectedImage !=
                                                null) {
                                              return Image(
                                                image: Image.file(controller
                                                        .selectedImage!)
                                                    .image,
                                                height: 300,
                                                width: 300,
                                              );
                                            } else if (controller
                                                .imagePath.value.isNotEmpty) {
                                              return Image(
                                                image: NetworkImage(
                                                    controller.imagePath.value),
                                                height: 300,
                                                width: 300,
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return Icon(
                                                Icons.account_circle,
                                                size: 300,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              );
                                            }
                                          }),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.pickImage();
                                        },
                                        style: ElevatedButton.styleFrom(
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "Ganti Foto",
                                            style: GoogleFonts.getFont(
                                              'Oswald',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : null)),
                ],
              ),
      ),
    );
  }
}
