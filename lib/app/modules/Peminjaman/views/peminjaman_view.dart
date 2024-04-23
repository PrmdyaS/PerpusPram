import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/model/response_borrow_book.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/peminjaman_controller.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PeminjamanController peminjamanController =
        Get.put(PeminjamanController());
    bool refresh = StorageProvider.read(StorageKey.refreshPeminjaman) ?? false;
    if (refresh) {
      peminjamanController.getData();
      StorageProvider.deleteStorage(StorageKey.refreshPeminjaman);
    }

    return RefreshIndicator(
      onRefresh: () => controller.getData(),
      child: Obx(() {
        if (controller.loading.value) {
          return ShimmerGroup();
        } else if (controller.responseBorrowBook.isEmpty) {
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
          return Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "List Peminjaman",
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
                                controller.responseBorrowBook.length ?? 0,
                            itemBuilder: (context, index) {
                              BorrowBook borrowBook =
                                  controller.responseBorrowBook[index];
                              if (borrowBook.books != null) {
                                if ("${borrowBook.status}" == "Dipinjam") {
                                  return ContainerDipinjam(
                                      borrowBook: borrowBook);
                                } else if ("${borrowBook.status}" == "Denda") {
                                  return ContainerDenda(borrowBook: borrowBook);
                                } else if ("${borrowBook.status}" ==
                                    "Menunggu Verifikasi") {
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
              ),
              Obx(() => AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: controller.isQRShowed.value ? 1.0 : 0.0,
                  child: controller.isQRShowed.value
                      ? GestureDetector(
                          onTap: () {
                            controller.isQRShowed(false);
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
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.isQRShowed(false);
                                    },
                                    style: ElevatedButton.styleFrom().copyWith(
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
            ],
          );
        }
      }),
    );
  }
}

String formatCurrency(int amount) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return currencyFormat.format(amount);
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
  final PeminjamanController peminjamanController =
      Get.put(PeminjamanController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        peminjamanController.isQRShowed(true);
        peminjamanController.qrValue.value = borrowBook.id ?? "";
      },
      child: Container(
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
                            Container(
                              width: 40,
                              child: Text(
                                "Note :",
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
                            Text(
                              "Kembalikan buku sebelum atau pada tanggal 21 Januari 2024.",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.primary,
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
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    "Dipinjam",
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
                  color: Success,
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

class ContainerDenda extends StatelessWidget {
  ContainerDenda({required this.borrowBook});

  final BorrowBook borrowBook;
  final PeminjamanController peminjamanController =
      Get.put(PeminjamanController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        peminjamanController.isQRShowed(true);
        peminjamanController.qrValue.value = borrowBook.id ?? "";
      },
      child: Container(
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
                            Container(
                              width: 40,
                              child: Text(
                                "Note :",
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
                            Text(
                              "Kembalikan buku, anda terkena DENDA!",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.primary,
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
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    "Denda",
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
  final PeminjamanController peminjamanController =
      Get.put(PeminjamanController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        peminjamanController.isQRShowed(true);
        peminjamanController.qrValue.value = borrowBook.id ?? "";
      },
      child: Container(
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
              right: 5,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    "Menunggu Verifikasi",
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
