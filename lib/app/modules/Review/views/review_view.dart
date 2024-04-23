import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beri Ulasan Buku',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        actions: [
          Obx(() => controller.loading.value
              ? Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator())
              : TextButton(
                  onPressed: controller.rating.value > 0
                      ? () {
                          if (Get.arguments['rating'] == null) {
                            controller.postReview();
                          } else {
                            controller.updateReview();
                          }
                        }
                      : null,
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ))
        ],
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 175,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        child: Image(
                          image: NetworkImage("${Get.arguments['sampul_buku']}"),
                          height: 175,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 175,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Get.arguments['judul']}",
                                style: GoogleFonts.getFont(
                                  'Oswald',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                "${Get.arguments['penulis']}",
                                style: GoogleFonts.getFont(
                                  'Roboto',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () =>
                                      controller.rating.value = index + 1,
                                  child: Obx(() => Icon(
                                        controller.rating.value >= index + 1
                                            ? Icons.star_rounded
                                            : Icons.star_border_rounded,
                                        color:
                                            controller.rating.value >= index + 1
                                                ? Warning
                                                : Colors.grey,
                                        size: 45,
                                      )),
                                );
                              }),
                            ),
                          ),
                          TextFormField(
                            controller: controller.ulasanController,
                            minLines: 1,
                            maxLines: 10,
                            maxLength: 500,
                            decoration: InputDecoration(
                              hintText: 'Deskripsikan ulasan Anda (opsional)',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Primary, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
