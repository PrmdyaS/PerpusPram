import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/detail_book_controller.dart';

class DetailBookView extends StatelessWidget {
  DetailBookView({Key? key}) : super(key: key);
  final DetailBookController controller = Get.put(DetailBookController());

  @override
  Widget build(BuildContext context) {
    double previousScrollPosition = 0;
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {
          if (scrollInfo.metrics.pixels > previousScrollPosition) {
            controller.showBottomNavBar.value = false;
          } else if (scrollInfo.metrics.pixels < previousScrollPosition) {
            controller.showBottomNavBar.value = true;
          }
          previousScrollPosition = scrollInfo.metrics.pixels;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Obx(
                () => controller.loadingFavorite.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: const IconButton(
                            icon: Icon(Icons.favorite, color: Colors.white),
                            onPressed: null),
                      )
                    : IconButton(
                        icon: Obx(() => controller.addFavorite.value
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border)),
                        onPressed: () {
                          if (controller.status.value == 'logged') {
                            controller.addToFavorite();
                          } else {
                            Get.toNamed(Routes.LOGIN, parameters: {
                              'page': 'detailbuku',
                              'id': '${Get.parameters['id']}',
                              'judul': '${Get.parameters['judul']}',
                              'penulis': '${Get.parameters['penulis']}',
                              'penerbit': '${Get.parameters['penerbit']}',
                              'sampul_buku': '${Get.parameters['sampul_buku']}',
                              'rating': '${Get.parameters['rating']}',
                            });
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
        extendBody: true,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchData();
          },
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Obx(() => controller.loadingData.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Shimmers(
                                      height: 200,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Container(
                                    width: 100,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              bottomLeft: Radius.circular(8.0),
                                            ),
                                            child: Image(
                                              image: NetworkImage(
                                                  '${controller.selectBook['sampul_buku']}'),
                                              height: 200,
                                              width: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${controller.selectBook['judul']}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${controller.selectBook['penulis']}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Wrap(
                                                        spacing: 10,
                                                        runSpacing: 5,
                                                        children: List.generate(
                                                            controller
                                                                    .selectBook[
                                                                        'genres']
                                                                    .length ??
                                                                0, (index) {
                                                          String genre = controller
                                                                      .selectBook[
                                                                  'genres'][index]
                                                              ['genres_name'];
                                                          String id = controller
                                                                      .selectBook[
                                                                  'genres']
                                                              [index]['_id'];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          100),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          100),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          100)),
                                                              border:
                                                                  Border.all(
                                                                color: Primary,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100.0),
                                                                onTap: () =>
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .LIST_BOOK,
                                                                        parameters: {
                                                                      'title':
                                                                          genre,
                                                                      'endpoint':
                                                                          "${Endpoint.allBooks}?genres_id=$id",
                                                                    }),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 3,
                                                                    right: 8,
                                                                    left: 8,
                                                                    bottom: 3,
                                                                  ),
                                                                  child: Text(
                                                                    genre,
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Poppins',
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Primary),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                        Obx(() => controller.loadingData.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[500]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Shimmers(
                                      height: 200,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) =>
                                            Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 10,
                                                    left: 10,
                                                    top: 20,
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Tahun Terbit',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.selectBook['tahun_terbit']}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Penerbit',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.selectBook['penerbit']}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Rating',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color:
                                                                    YellowStar,
                                                                size: 15,
                                                              ),
                                                              Text(
                                                                '${controller.selectBook['rating'] ?? '0.0'}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        12,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                height: 0.2,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 5,
                                                    bottom: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Deskripsi Buku : ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    ExpandableText(
                                                      text:
                                                          '${controller.selectBook['deskripsi_buku']}',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              )),
                        Obx(
                          () => controller.loadingRekomendasi.value
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[500]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Shimmers(
                                          height: 200,
                                        ),
                                      )),
                                )
                              : ListKategori(
                                  dataBooks: controller.rekomendasiBookList,
                                  categoryTitle: 'Rekomendasi',
                                  endpoint:
                                      controller.endpointRekomendasi.value,
                                ),
                        ),
                        Obx(() {
                          if (controller.loadingUlasanAnda.value) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[500]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Shimmers(
                                      height: 200,
                                    ),
                                  )),
                            );
                          } else if (controller.count.value == 0) {
                            return Container();
                          } else {
                            return Container(
                              margin: const EdgeInsets.only(
                                  right: 15, left: 15, top: 10, bottom: 10),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Ulasan Anda",
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.listUlasanAnda.length,
                                        itemBuilder: (context, index) {
                                          int rating = controller
                                              .listUlasanAnda[index]['rating'];
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Obx(() {
                                                      if ('${controller.listUlasanAnda[index]['borrow_books']['users']['profile_picture']}' ==
                                                          '') {
                                                        return SizedBox(
                                                          width: 35,
                                                          height: 35,
                                                          child: Icon(
                                                            Icons
                                                                .account_circle,
                                                            size: 35,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                        );
                                                      } else {
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                              100,
                                                            ),
                                                          ),
                                                          child: Image(
                                                            image: NetworkImage(
                                                              '${controller.listUlasanAnda[index]['borrow_books']['users']['profile_picture']}',
                                                            ),
                                                            height: 35,
                                                            width: 35,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      '${controller.listUlasanAnda[index]['borrow_books']['users']['username']}',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(5,
                                                          (index) {
                                                        return Icon(
                                                            rating >= index + 1
                                                                ? Icons
                                                                    .star_rounded
                                                                : Icons
                                                                    .star_border_rounded,
                                                            color: rating >=
                                                                    index + 1
                                                                ? Warning
                                                                : Colors.grey,
                                                            size: 16);
                                                      }),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      convertDateFormat(
                                                          '${controller.listUlasanAnda[index]['created_at']}'),
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Obx(() {
                                                  if (controller.listUlasanAnda[
                                                              index]
                                                          ['review_text'] !=
                                                      '') {
                                                    return AnimatedCrossFade(
                                                      duration: const Duration(
                                                          milliseconds: 1),
                                                      crossFadeState: controller
                                                              .expandedReview
                                                              .value
                                                          ? CrossFadeState
                                                              .showSecond
                                                          : CrossFadeState
                                                              .showFirst,
                                                      firstChild:
                                                          GestureDetector(
                                                        onTap: () => controller
                                                            .expandedReview(
                                                                true),
                                                        child: Text(
                                                          '${controller.listUlasanAnda[index]['review_text']}',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      secondChild:
                                                          GestureDetector(
                                                        onTap: () => controller
                                                            .expandedReview(
                                                                false),
                                                        child: Text(
                                                          '${controller.listUlasanAnda[index]['review_text']}',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                                SizedBox(height: 15),
                                                ElevatedButton(
                                                  onPressed: () => Get.toNamed(
                                                      Routes.REVIEW,
                                                      arguments: {
                                                        'id':
                                                            '${controller.listUlasanAnda[index]['_id']}',
                                                        'sampul_buku':
                                                            '${controller.selectBook['sampul_buku']}',
                                                        'judul':
                                                            '${controller.selectBook['judul']}',
                                                        'penulis':
                                                            '${controller.selectBook['penulis']}',
                                                        'rating': '$rating',
                                                        'review_text':
                                                            '${controller.listUlasanAnda[index]['review_text']}',
                                                        'user_id': controller
                                                            .userId.value,
                                                        'book_id':
                                                            Get.arguments['id']
                                                      }),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                  ).copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Primary),
                                                  ),
                                                  child: Text(
                                                    "Edit ulasan Anda",
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      textStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                        Obx(() {
                          if (controller.loadingUlasan.value) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[500]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Shimmers(
                                      height: 200,
                                    ),
                                  )),
                            );
                          } else if (controller.count.value == 0) {
                            return Container();
                          } else {
                            return GestureDetector(
                              onTap: () => Get.toNamed(Routes.LIST_ULASAN,
                                  arguments: {'id': Get.arguments['id']}),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 15, left: 15, top: 10, bottom: 50),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rating dan ulasan",
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () => {null},
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.count.value,
                                            itemBuilder: (context, index) {
                                              int rating = controller
                                                  .listUlasan[index]['rating'];
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                Icons
                                                                    .account_circle,
                                                                size: 35,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            );
                                                          } else {
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                  100,
                                                                ),
                                                              ),
                                                              child: Image(
                                                                image:
                                                                    NetworkImage(
                                                                  '${controller.listUlasan[index]['borrow_books']['users']['profile_picture']}',
                                                                ),
                                                                height: 35,
                                                                width: 35,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          '${controller.listUlasan[index]['borrow_books']['users']['username']}',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children:
                                                              List.generate(5,
                                                                  (index) {
                                                            return Icon(
                                                                rating >=
                                                                        index +
                                                                            1
                                                                    ? Icons
                                                                        .star_rounded
                                                                    : Icons
                                                                        .star_border_rounded,
                                                                color: rating >=
                                                                        index +
                                                                            1
                                                                    ? Warning
                                                                    : Colors
                                                                        .grey,
                                                                size: 16);
                                                          }),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          convertDateFormat(
                                                              '${controller.listUlasan[index]['created_at']}'),
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Obx(() => AnimatedCrossFade(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1),
                                                          crossFadeState: controller
                                                                  .expandedReview
                                                                  .value
                                                              ? CrossFadeState
                                                                  .showSecond
                                                              : CrossFadeState
                                                                  .showFirst,
                                                          firstChild:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .expandedReview(
                                                                    true),
                                                            child: Text(
                                                              '${controller.listUlasan[index]['review_text']}',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          secondChild:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .expandedReview(
                                                                    false),
                                                            child: Text(
                                                              '${controller.listUlasan[index]['review_text']}',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Poppins',
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Theme.of(
                                                                          context)
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
                              ),
                            );
                          }
                        })
                      ],
                    ),
                  ),
                ),
                Obx(() => AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: controller.isDateShowed.value ? 1.0 : 0.0,
                    child: controller.isDateShowed.value
                        ? GestureDetector(
                            onTap: () {
                              controller.isDateShowed(false);
                              controller.showBottomNavBar(true);
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Form(
                                  key: controller.formKey,
                                  child: GestureDetector(
                                    onTap: () {
                                      null;
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      decoration: BoxDecoration(
                                        color: Primary,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DateTimePicker(
                                              icon: const Icon(
                                                Icons.calendar_today,
                                                color: Colors.white,
                                              ),
                                              controller: controller
                                                  .tanggalPinjamController,
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                              dateLabelText:
                                                  'Pilih tanggal pinjam',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              cursorColor: Colors.white,
                                              dateMask: 'yyyy-MM-dd',
                                              onChanged: (val) => print(val),
                                              validator: (val) {
                                                DateTime value = DateTime.parse('$val').add(Duration(days: 1));
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Tanggal pinjam harus diisi';
                                                } else if (value.isBefore(DateTime.now())) {
                                                  return 'Tanggal pinjam tidak boleh sebelum hari ini!';
                                                }
                                                return null;
                                              },
                                            ),
                                            // DateTimePicker(
                                            //   icon: const Icon(
                                            //     Icons.calendar_today,
                                            //     color: Colors.white,
                                            //   ),
                                            //   controller: controller
                                            //       .tanggalKembaliController,
                                            //   firstDate: DateTime(2000),
                                            //   lastDate: DateTime(2100),
                                            //   dateLabelText:
                                            //       'Pilih tanggal kembali',
                                            //   style: TextStyle(
                                            //       color: Colors.white),
                                            //   dateMask: 'yyyy-MM-dd',
                                            //   onChanged: (val) => print(val),
                                            //   validator: (val) {
                                            //     if (val == null ||
                                            //         val.isEmpty) {
                                            //       return 'Tanggal Kembali harus diisi';
                                            //     }
                                            //     return null;
                                            //   },
                                            // ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: const Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Obx(() => controller
                                                        .loadingAddPeminjaman
                                                        .value
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Primary),
                                                      )
                                                    : ElevatedButton(
                                                        onPressed: () =>
                                                            controller
                                                                .addPeminjaman(
                                                                    Get.arguments[
                                                                        'id']),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .transparent),
                                                          elevation:
                                                              MaterialStateProperty
                                                                  .all(0),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart_outlined,
                                                              color: Primary,
                                                              size: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5),
                                                              child: Text(
                                                                'Pinjam',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      Primary,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null)),
                Obx(() => AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: controller.isQRShowed.value ? 1.0 : 0.0,
                    child: controller.isQRShowed.value
                        ? GestureDetector(
                            onTap: () {
                              controller.isQRShowed(false);
                              controller.showBottomNavBar(true);
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Primary,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: QrImageView(
                                          data: controller.qrValue.value,
                                          version: QrVersions.auto,
                                          size: 275.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.isQRShowed(false);
                                        controller.showBottomNavBar(true);
                                      },
                                      style:
                                          ElevatedButton.styleFrom().copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(Primary),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Tutup",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : null)),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: controller.showBottomNavBar.value ? 1.0 : 0.0,
                      child: Visibility(
                        visible: controller.showBottomNavBar.value,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 12),
                          decoration: BoxDecoration(
                            color: Primary,
                            borderRadius: BorderRadius.circular(100),
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
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.status.value == 'logged') {
                                controller.isDateShowed(true);
                                controller.showBottomNavBar(false);
                              } else {
                                Get.toNamed(Routes.LOGIN, parameters: {
                                  'page': 'detailbukupinjam',
                                  'id': '${Get.parameters['id']}',
                                  'judul': '${Get.parameters['judul']}',
                                  'penulis': '${Get.parameters['penulis']}',
                                  'penerbit': '${Get.parameters['penerbit']}',
                                  'sampul_buku':
                                      '${Get.parameters['sampul_buku']}',
                                  'rating': '${Get.parameters['rating']}',
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Pinjam',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({
    required this.text,
    this.maxLines = 5,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.text,
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
            ),
          ),
          secondChild: Text(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Show Less' : 'Show More',
            style: TextStyle(
              color: Primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class ListKategori extends StatelessWidget {
  ListKategori({
    required this.dataBooks,
    required this.categoryTitle,
    required this.endpoint,
  });

  final String categoryTitle;
  final String endpoint;
  final List<DataBook> dataBooks;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (dataBooks.isNotEmpty) {
            Get.toNamed(Routes.LIST_BOOK, parameters: {
              'title': categoryTitle,
              'endpoint': endpoint,
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categoryTitle,
                          style: GoogleFonts.getFont('Poppins',
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.primary))),
                      Icon(Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20),
                    ],
                  ),
                ),
                if (dataBooks.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kami tidak menemui hasil YANG COCOK",
                            style: GoogleFonts.getFont(
                              'Bebas Neue',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(Icons.find_in_page_outlined,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary)
                        ],
                      ),
                    ),
                  ),
                if (dataBooks.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Container(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataBooks.length,
                        itemBuilder: (context, index) {
                          return KategoriItem(dataBook: dataBooks[index]);
                        },
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

class KategoriItem extends StatelessWidget {
  KategoriItem({required this.dataBook});

  final detailBookController = Get.find<DetailBookController>();
  final DataBook dataBook;

  @override
  Widget build(BuildContext context) {
    String judul = dataBook.judul ?? '';
    if (judul.length > 23) {
      judul = '${judul.substring(0, 23)}...';
    }
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailBookView(), arguments: {
          'id': '${dataBook.id}',
          'penerbit': '${dataBook.penerbit}',
        });
        // Get.to(() => DetailBookView(), binding: BindingsBuilder(() {
        //   Get.create<DetailBookController>(() => DetailBookController());
        // }));

        detailBookController.fetchData();

        // var result =
        //     Get.to(() => DetailBookView(), binding: BindingsBuilder(() {
        //   Get.create<DetailBookController>(() => DetailBookController());
        // }), arguments: {
        //   'id': '${dataBook.id}',
        //   'penerbit': '${dataBook.penerbit}',
        // });
        //
        // if (result != null) {
        //   result.then((value) {
        //     DetailBookController detailBookController =
        //         Get.find<DetailBookController>();
        //     detailBookController.fetchData();
        //   });
        //   print("if");
        //   print("${result}");
        // } else {
        //   print("else");
        //   print("${result}");
        // }

        // Get.to(() => DetailBookView(), arguments: {
        //   'id': '${dataBook.id}',
        //   'penerbit': '${dataBook.penerbit}',
        // });
        // detailBookController.fetchData();
        // Get.find<DetailBookController>();
        // print("aedku");
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10, right: 10),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image(
                  image: NetworkImage("${dataBook.sampulBuku}"),
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Container(
                  height: 45,
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Text(
                          judul,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: YellowStar,
                              size: 15,
                            ),
                            Text("${dataBook.rating ?? '0.0'}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 10)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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

String convertDateFormat(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate =
      '${dateTime.day}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year % 100}';
  return formattedDate;
}
