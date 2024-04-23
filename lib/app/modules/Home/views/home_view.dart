import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/data/model/response_sub_categories.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getData(),
      child: Obx(() => controller.loading.value
          ? ShimmerGroup()
          : Container(
              color: Theme.of(context).colorScheme.surface,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Column(
                      children: [
                        SearchBar(),
                        CarouselWidget(),
                        Container(
                            height: 50,
                            child: ButtonList(
                                dataSubCategories:
                                    homeController.subCategoriesList)),
                        if (controller.role.value == '2')
                          Container(
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
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Get.toNamed(Routes.MENU_BUKU),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blueAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.menu_book_rounded,
                                                    color: Colors.blueAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Menu Buku",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Get.toNamed(
                                            Routes.LAPORAN_PEMINJAMAN),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.greenAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.library_books_rounded,
                                                    color: Colors.greenAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Laporan Peminjaman",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Get.toNamed(Routes.LAPORAN_DENDA),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.redAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.money_off_rounded,
                                                    color: Colors.redAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Laporan Denda",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (controller.role.value == '3')
                          Container(
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
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Get.toNamed(Routes.MENU_BUKU),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.blueAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.menu_book_rounded,
                                                    color: Colors.blueAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Menu Buku",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Get.toNamed(
                                            Routes.LAPORAN_PEMINJAMAN),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.greenAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.library_books_rounded,
                                                    color: Colors.greenAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Laporan Peminjaman",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Get.toNamed(Routes.LAPORAN_DENDA),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.redAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.money_off_rounded,
                                                    color: Colors.redAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Laporan Denda",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Get.toNamed(Routes.MANAGEMENT_USER),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 60,
                                          width: 73,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.amberAccent
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.amberAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Management User",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                  'Bebas Neue',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                  textStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ListRekomendasi(
                          dataBooks: homeController.rekomendasiBookList,
                          categoryTitle: 'Rekomendasi',
                          endpoint: homeController.endpointRekomendasi,
                        ),
                        ListKategori(
                          dataBooks: homeController.terbaruBookList,
                          categoryTitle: 'Terbaru',
                          endpoint: homeController.endpointTerbaru,
                        ),
                        ListKategori(
                          dataBooks: homeController.ratingTertinggiBookList,
                          categoryTitle: 'Rating Tertinggi',
                          endpoint: homeController.endpointRatingTertinggi,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.SEARCH_PAGE),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                    Text("Cari judul, pengarang, atau penerbit",
                        style: GoogleFonts.getFont('Roboto',
                            fontSize: 14,
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb6y70d_Sza7w0reKa9MvSTDoi7dKcpy2fzMTNk8bypw&s',
    'https://tse1.mm.bing.net/th?id=OIP.sbA7jfZApmeT2lgce3tP8gHaDt&pid=Api&P=0&h=180',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            // enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imgList
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      child: Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: 1000,
                        ),
                      )),
                    ),
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 20.0,
          child: DotsIndicator(
            dotsCount: imgList.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              color: Theme.of(context).colorScheme.background.withOpacity(0.4),
              activeColor: Primary.withOpacity(0.9),
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonList extends StatelessWidget {
  ButtonList({required this.dataSubCategories});

  final List<DataSubCategories> dataSubCategories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataSubCategories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
          child: CustomButton(
              label: "${dataSubCategories[index].subCategoriesName}",
              id: "${dataSubCategories[index].id}"),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final String id;

  const CustomButton({Key? key, required this.label, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: Primary,
          width: 3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: () => Get.toNamed(Routes.LIST_BOOK, parameters: {
            'title': label,
            'endpoint': "${Endpoint.allBooks}?sub_categories_id=$id",
          }),
          child: Container(
            padding: EdgeInsets.only(
              top: 5,
              right: 25,
              left: 25,
              bottom: 5,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final DataBook dataBook;

  CustomListItem({required this.dataBook});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/app/assets/image/coverbuku.jpg'),
          ),
          title: Text(dataBook.judul ?? ''),
          subtitle: Text(
            '${dataBook.penulis ?? ''} - ${dataBook.penerbit ?? ''} (${dataBook.tahunTerbit ?? ''})',
            style: TextStyle(color: Colors.red),
          ),
          trailing: IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Aksi ketika tombol ditekan
            },
          ),
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<DataBook> dataBooks;

  CustomListView({required this.dataBooks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        itemCount: dataBooks.length,
        itemBuilder: (context, index) {
          return CustomListItem(dataBook: dataBooks[index]);
        },
      ),
    );
  }
}

class ListRekomendasi extends StatelessWidget {
  ListRekomendasi({
    required this.dataBooks,
    required this.categoryTitle,
    required this.endpoint,
  });

  final String categoryTitle;
  final String endpoint;
  final HomeController homeController = Get.put(HomeController());
  final List<DataBook> dataBooks;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Primary,
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.LIST_BOOK, parameters: {
          'title': categoryTitle,
          'endpoint': endpoint,
        }),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categoryTitle,
                        style: GoogleFonts.getFont(
                          'Poppins',
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5, bottom: 5),
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

class ListKategori extends StatelessWidget {
  ListKategori({
    required this.dataBooks,
    required this.categoryTitle,
    required this.endpoint,
  });

  final String categoryTitle;
  final String endpoint;
  final HomeController homeController = Get.put(HomeController());
  final List<DataBook> dataBooks;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.LIST_BOOK, parameters: {
            'title': categoryTitle,
            'endpoint': endpoint,
          });
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

  final DataBook dataBook;

  @override
  Widget build(BuildContext context) {
    String judul = dataBook.judul ?? '';
    if (judul.length > 23) {
      judul = judul.substring(0, 23) + '...';
    }
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_BOOK, arguments: {
          'id': '${dataBook.id}',
          'penerbit': '${dataBook.penerbit}',
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 10, right: 10),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.1),
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
                        "${dataBook.sampulBuku ?? 'lib/app/assets/image/coverbuku.jpg'}"),
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
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
                        child: Text("$judul",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 10)),
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

class ShimmerGroup extends StatelessWidget {
  const ShimmerGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: SingleChildScrollView(
            child: Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Shimmers(height: 40),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Shimmers(height: 40, width: 35),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Shimmers(
                      height: 200,
                    )),
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        child: Shimmers(
                          width: 100,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmers(
                                height: 30,
                                width: 150,
                              ),
                              Shimmers(
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, bottom: 5),
                          child: Container(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10),
                                  child: Shimmers(
                                    width: 100,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(),
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
                              Shimmers(
                                height: 30,
                                width: 150,
                              ),
                              Shimmers(
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: Container(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10),
                                  child: Shimmers(
                                    width: 100,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
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
