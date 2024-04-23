import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.queryController.text = controller.query.value;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.SEARCH_PAGE),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.background)),
                  child: Row(
                    children: [
                      Icon(Icons.search,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        height: 20,
                        child: TextFormField(
                          controller: controller.queryController,
                          autofocus: true,
                          onChanged: (value) {
                            controller.getSearch(value);
                          },
                          onEditingComplete: () {
                            controller.getData(controller.queryController.text);
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari judul, pengarang, atau penerbit',
                            hintStyle: GoogleFonts.getFont('Roboto',
                                fontSize: 14,
                                textStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            contentPadding: EdgeInsets.zero,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(
            () => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : Obx(() {
          if (controller.search.value) {
            if (!controller.searchData.value) {
              return ListView.builder(
                itemCount: controller.responseQuery.data?.length,
                itemBuilder: (context, index) {
                  String item =
                      controller.responseQuery.data?[index] ?? "";
                  return ListTile(
                      title: Text(item),
                      leading: Icon(Icons.search),
                      onTap: () {
                        controller.queryController.text = item;
                        controller.getData(item);
                      });
                },
              );
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Theme.of(context).colorScheme.background,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 15,
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
                                'sampul_buku': '${book.sampulBuku}',
                                'rating': '${book.rating}',
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
                                          image: NetworkImage(book.sampulBuku ??
                                              'lib/app/assets/image/coverbuku.jpg'),
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
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          return Container();
        }),
      ),
    );
  }
}
