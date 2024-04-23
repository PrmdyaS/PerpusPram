import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/list_ulasan_controller.dart';

class ListUlasanView extends GetView<ListUlasanController> {
  const ListUlasanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Obx(() {
          if (controller.loadingUlasan.value) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[500]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Shimmers(
                      height: 200,
                    ),
                  )),
            );
          } else if (controller.listUlasan.isEmpty) {
            return Container();
          } else {
            return Container(
              margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rating dan ulasan",
                          style: GoogleFonts.getFont(
                            'Poppins',
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.listUlasan.length,
                          itemBuilder: (context, index) {
                            int rating = controller.listUlasan[index]['rating'];
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Obx(() {
                                        if ('${controller.listUlasan[index]['borrow_books']['users']['profile_picture']}' ==
                                            '') {
                                          return SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Icon(
                                              Icons.account_circle,
                                              size: 35,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          );
                                        } else {
                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                100,
                                              ),
                                            ),
                                            child: Image(
                                              image: NetworkImage(
                                                '${controller.listUlasan[index]['borrow_books']['users']['profile_picture']}',
                                              ),
                                              height: 35,
                                              width: 35,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                      }),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${controller.listUlasan[index]['borrow_books']['users']['username']}',
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(5, (index) {
                                          return Icon(
                                              rating >= index + 1
                                                  ? Icons.star_rounded
                                                  : Icons.star_border_rounded,
                                              color: rating >= index + 1
                                                  ? Warning
                                                  : Colors.grey,
                                              size: 16);
                                        }),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        convertDateFormat(
                                            '${controller.listUlasan[index]['created_at']}'),
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Obx(() => AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 1),
                                        crossFadeState:
                                            controller.expandedReview.value
                                                ? CrossFadeState.showSecond
                                                : CrossFadeState.showFirst,
                                        firstChild: GestureDetector(
                                          onTap: () =>
                                              controller.expandedReview(true),
                                          child: Text(
                                            '${controller.listUlasan[index]['review_text']}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        secondChild: GestureDetector(
                                          onTap: () =>
                                              controller.expandedReview(false),
                                          child: Text(
                                            '${controller.listUlasan[index]['review_text']}',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

String convertDateFormat(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate =
      '${dateTime.day}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year % 100}';
  return formattedDate;
}

class Shimmers extends StatelessWidget {
  const Shimmers({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );
  }
}
