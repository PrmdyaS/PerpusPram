import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/model/response_borrow_book.dart';
import 'package:perpus_pram/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/riwayat_peminjaman_controller.dart';

class RiwayatPeminjamanView extends GetView<RiwayatPeminjamanController> {
  const RiwayatPeminjamanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RiwayatPeminjamanController riwayatPeminjamanController =
        Get.put(RiwayatPeminjamanController());

    return RefreshIndicator(
      onRefresh: () => controller.getData(),
      child: Obx(() {
        if (controller.loading.value) {
          return ShimmerGroup();
        } else if (controller.responseHistoryBorrowBook.isEmpty) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kamu belum meminjam apapun",
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
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Riwayat Peminjaman",
                      style: GoogleFonts.getFont(
                        'Oswald',
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            controller.responseHistoryBorrowBook.length ?? 0,
                        itemBuilder: (context, index) {
                          BorrowBook borrowBook =
                              controller.responseHistoryBorrowBook[index];
                          if (borrowBook.books != null) {
                            if ("${borrowBook.status}" == "Tepat Waktu") {
                              return ContainerDipinjam(borrowBook: borrowBook);
                            } else if ("${borrowBook.status}" ==
                                "Denda Lunas") {
                              return ContainerDenda(borrowBook: borrowBook);
                            } else if ("${borrowBook.status}" == "Dibatalkan") {
                              return ContainerMenungguVerifikasi(
                                  borrowBook: borrowBook);
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}

String formatDate(String dateString) {
  if (dateString != '') {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMMM yyyy', 'id');
    return formatter.format(date);
  }
  return '';
}

String hitungDurasi(String tanggalPinjam, String tanggalKembali) {
  DateTime pinjam = DateFormat('yyyy-MM-dd').parse(tanggalPinjam);
  DateTime kembali = DateFormat('yyyy-MM-dd').parse(tanggalKembali);
  Duration durasi = kembali.difference(pinjam);
  return durasi.inDays.toString();
}

class ContainerDipinjam extends StatelessWidget {
  ContainerDipinjam({required this.borrowBook});

  final BorrowBook borrowBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (borrowBook.review == 1) {
          Fluttertoast.showToast(
            msg: "Anda sudah memberikan ulasan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Primary,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Get.toNamed(Routes.REVIEW, arguments: {
            'borrow_books_id': '${borrowBook.id}',
            'sampul_buku': '${borrowBook.books?.sampulBuku}',
            'judul': '${borrowBook.books?.judul}',
            'penulis': '${borrowBook.books?.penulis}',
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 175,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
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
                      offset: Offset(1, 1),
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
                        image: NetworkImage("${borrowBook.books?.sampulBuku}"),
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
                              "${borrowBook.books?.judul}",
                              style: GoogleFonts.getFont(
                                'Oswald',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            Text(
                              "${borrowBook.books?.penulis}",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Pinjam selama",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "${hitungDurasi('${borrowBook.borrowingDate ?? ''}', '${borrowBook.returnDate ?? ''}')} Hari",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Tanggal Peminjaman",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    formatDate('${borrowBook.borrowingDate}'),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Tanggal Pengembalian",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    formatDate(
                                        '${borrowBook.returnDate ?? ''}'),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                        color: Primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 110,
              child: borrowBook.review == 1
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        child: Text(
                          "Beri ulasan buku",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Success,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    "Tepat Waktu",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerDenda extends StatelessWidget {
  ContainerDenda({required this.borrowBook});

  final BorrowBook borrowBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (borrowBook.review == 1) {
          Get.snackbar("Sorry", "Anda sudah memberikan ulasan",
              backgroundColor: Colors.greenAccent);
        } else {
          Get.toNamed(Routes.REVIEW, arguments: {
            'borrow_books_id': '${borrowBook.id}',
            'sampul_buku': '${borrowBook.books?.sampulBuku}',
            'judul': '${borrowBook.books?.judul}',
            'penulis': '${borrowBook.books?.penulis}',
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 175,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
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
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        child: Image(
                          image: NetworkImage(
                              "${borrowBook.books?.sampulBuku ?? 'lib/app/assets/image/coverbuku.jpg'}"),
                          height: 175,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 175,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${borrowBook.books?.judul ?? ''}",
                              style: GoogleFonts.getFont(
                                'Oswald',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            Text(
                              "${borrowBook.books?.penulis ?? ''}",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Pinjam selama",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "${hitungDurasi('${borrowBook.borrowingDate ?? ''}', '${borrowBook.returnDate ?? ''}')} Hari",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Tanggal Peminjaman",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    formatDate(
                                        '${borrowBook.borrowingDate ?? ''}'),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Tanggal Pengembalian",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    formatDate(
                                        '${borrowBook.returnDate ?? ''}'),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                        color: Primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Total Denda",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    formatCurrency(borrowBook.denda ?? 0),
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                        color: Danger,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 110,
              child: borrowBook.review == 1
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        child: Text(
                          "Beri ulasan buku",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    "Denda Lunas",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Danger,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerMenungguVerifikasi extends StatelessWidget {
  ContainerMenungguVerifikasi({required this.borrowBook});

  final BorrowBook borrowBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 175,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      child: Image(
                        image: NetworkImage(
                            "${borrowBook.books?.sampulBuku ?? 'lib/app/assets/image/coverbuku.jpg'}"),
                        height: 175,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${borrowBook.books?.judul}",
                            style: GoogleFonts.getFont(
                              'Oswald',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Text(
                            "${borrowBook.books?.penulis ?? ''}",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  "Pinjam selama",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10,
                                child: Text(
                                  ":",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  "${hitungDurasi('${borrowBook.borrowingDate ?? ''}', '${borrowBook.returnDate ?? ''}')} Hari",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  "Tanggal Peminjaman",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10,
                                child: Text(
                                  ":",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  formatDate(
                                      '${borrowBook.borrowingDate ?? ''}'),
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  "Tanggal Pengembalian",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10,
                                child: Text(
                                  ":",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  formatDate('${borrowBook.returnDate ?? ''}'),
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10,
                                      color: Primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 110,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Text(
                  "Beri ulasan buku",
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 8,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Text(
                  "Dibatalkan",
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Warning,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
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
        child: Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmers(
                  height: 30,
                  width: 135,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Shimmers(
                          width: double.infinity,
                          height: 175,
                        ),
                      );
                    },
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

String formatCurrency(int amount) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return currencyFormat.format(amount);
}
