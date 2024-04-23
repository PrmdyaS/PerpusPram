import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/list_book_controller.dart';

class ListBookView extends GetView<ListBookController> {
  ListBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.loading.value
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: Shimmers(
                    height: 25,
                    width: 160,
                  ),
                )
              : Text(
                  '${Get.parameters['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getData(),
        child: Obx(() {
          if (controller.loading.value) {
            return ShimmerGroup();
          } else if (controller.responseBook.isEmpty) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Kami tidak menemui hasil apapun",
                    style: GoogleFonts.getFont(
                      'Bebas Neue',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(Icons.find_in_page_outlined,
                      size: 24, color: Theme.of(context).colorScheme.primary)
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  color: Theme.of(context).colorScheme.background,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      controller.responseBook.length ?? 0,
                      (index) {
                        DataBook book = controller.responseBook[index];
                        String judul = book.judul ?? '';
                        if (judul.length > 25) {
                          judul = judul.substring(0, 25) + '...';
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_BOOK, arguments: {
                              'id': (book.id).toString(),
                              'judul': '${book.judul}',
                              'penulis': '${book.penulis}',
                              'penerbit': '${book.penerbit}',
                              'tahun_terbit': '${book.tahunTerbit}',
                              'sampul_buku': '${book.sampulBuku}',
                              'rating': '${book.rating}',
                              'title': '${Get.parameters['title'] ?? ''}'
                            });
                          },
                          child: Container(
                            height: 340,
                            width: 170,
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
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                        book.sampulBuku ??
                                            'lib/app/assets/image/coverbuku.jpg',
                                      ),
                                      height: 250,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5, bottom: 5),
                                    child: Container(
                                      width: 170,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$judul",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  book.penulis ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 2,
                                            bottom: 2,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: YellowStar,
                                                  size: 15,
                                                ),
                                                Text(
                                                  book.rating ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

class ShimmerGroup extends StatelessWidget {
  const ShimmerGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          color: Theme.of(context).colorScheme.background,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[100]!,
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: List.generate(
                4,
                (index) {
                  return Shimmers(
                    height: 340,
                    width: 170,
                  );
                },
              ),
            ),
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
