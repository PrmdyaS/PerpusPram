import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getData(),
      child: Obx(
        () => profileController.loading.value
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Obx(
                                () => profileController.isVisible.value
                                    ? Obx(() {
                                        if (profileController
                                                .profilePicture.value ==
                                            '') {
                                          return const Icon(
                                            Icons.account_circle,
                                            size: 90,
                                            color: Colors.white,
                                          );
                                        } else {
                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                            child: Image(
                                              image: NetworkImage(
                                                  profileController
                                                      .profilePicture.value),
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                      })
                                    : const Icon(
                                        Icons.account_circle,
                                        size: 90,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            Obx(
                              () => profileController.isVisible.value
                                  ? Visibility(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(
                                            () => Text(
                                              profileController.username.value,
                                              style: GoogleFonts.getFont(
                                                'Roboto',
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 28,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () => Get.toNamed(
                                                  Routes.EDIT_PROFILE),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 34),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ).copyWith(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .surface),
                                              ),
                                              child: Text("Edit Profil",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14)))
                                        ],
                                      ),
                                    )
                                  : Visibility(
                                      child: Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed(Routes.LOGIN);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                ).copyWith(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .surface),
                                                ),
                                                child: Text("Masuk",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 20))),
                                            ElevatedButton(
                                                onPressed: () => Get.toNamed(
                                                    Routes.REGISTER),
                                                style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 18,
                                                                vertical: 10),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        side: BorderSide(
                                                            color: Colors.white,
                                                            width: 2))
                                                    .copyWith(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Primary),
                                                ),
                                                child: Text("Daftar",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 20,
                                                        color: Colors.white)))
                                          ],
                                        ),
                                      ),
                                    )),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.status == 'logged') {
                            Get.toNamed(Routes.LIST_BOOK, parameters: {
                              'title': 'Favorit Saya',
                              'endpoint': '${controller.endpointFavoritSaya}'
                            });
                          } else {
                            Get.toNamed(Routes.LOGIN,
                                parameters: {'page': 'favoritsaya'});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text("Favorit Saya",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Apakah akan Logout?",
                            content: Container(),
                            backgroundColor: Primary,
                            textConfirm: "Logout",
                            textCancel: "Batal",
                            titleStyle: TextStyle(color: Colors.white),
                            cancelTextColor: Colors.white,
                            buttonColor: Colors.white,
                            confirmTextColor: Primary,
                            onConfirm: () => profileController.logout(),
                            onCancel: () => Get.back(closeOverlays: true),
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                                child: Icon(
                                  Icons.logout,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text("Logout",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
