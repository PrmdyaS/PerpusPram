import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  ScanView({Key? key}) : super(key: key);
  final ScanController scanController = Get.put(ScanController());

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
                  controller.title.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (controller.loading.value) {
              return ShimmerGroup();
            } else if (controller.msg.value != "") {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.msg.value,
                    style: GoogleFonts.getFont(
                      'Bebas Neue',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(Icons.error_outline,
                      size: 24, color: Theme.of(context).colorScheme.primary)
                ],
              );
            } else if (controller.status.value == "Menunggu Verifikasi" || controller.status.value == "Dipinjam" || controller.status.value == "Denda") {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image(
                                    image: NetworkImage(controller
                                        .dataBorrowBook
                                        .value['books']['sampul_buku']),
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Kode Peminjaman",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller.dataBorrowBook.value['_id'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Nama",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller.dataBorrowBook.value['users']
                                          ['username'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Judul",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller.dataBorrowBook.value['books']
                                          ['judul'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Tanggal Pinjam",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller.dataBorrowBook
                                          .value['borrowing_date'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Tanggal Kembali",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller
                                          .dataBorrowBook.value['return_date'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Status",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      controller.dataBorrowBook.value['status'],
                                      style: GoogleFonts.getFont(
                                        'Oswald',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Obx(() {
                                if (controller.dataBorrowBook.value['status'] ==
                                    'Denda') {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Total Denda",
                                          style: GoogleFonts.getFont(
                                            'Oswald',
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          ":",
                                          style: GoogleFonts.getFont(
                                            'Oswald',
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Text(
                                          formatCurrency(controller
                                              .dataBorrowBook.value['denda']),
                                          style: GoogleFonts.getFont(
                                            'Oswald',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Danger),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Obx(() {
                        if (controller.dataBorrowBook.value['status'] ==
                            'Denda') {
                          return Container(
                            decoration: BoxDecoration(
                              color: Danger,
                              borderRadius: BorderRadius.circular(8),
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
                            child: ElevatedButton(
                              onPressed: () => controller.isVisible(true),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                width: 140,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.article_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "LUNASI DENDA",
                                      style: GoogleFonts.getFont(
                                        'Bebas Neue',
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
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
                                child: ElevatedButton(
                                  onPressed: () => controller.tolakFunction(),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: Danger,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "TOLAK",
                                          style: GoogleFonts.getFont(
                                            'Bebas Neue',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(8),
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
                                child: ElevatedButton(
                                  onPressed: () => controller.terimaFunction(),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Success,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "TERIMA",
                                          style: GoogleFonts.getFont(
                                            'Bebas Neue',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ],
                  ),
                  Obx(() => controller.alertDialog.value == ''
                      ? Container()
                      : AlertDialog(
                          title: Text(
                            'Berhasil',
                            style: GoogleFonts.bebasNeue(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 30),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          content: Text(
                            controller.alertDialog.value,
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                controller.alertDialog.value = '';
                                Get.back(closeOverlays: true);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Success),
                              ),
                              child: Text(
                                'Tutup',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )),
                  Obx(() => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: controller.isVisible.value ? 1.0 : 0.0,
                      child: controller.isVisible.value
                          ? SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: GestureDetector(
                                onTap: () {
                                  controller.isVisible(false);
                                  controller.errorBuktiPembayaran(false);
                                  controller.errorPaymentMethod(false);
                                },
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  width: MediaQuery.of(context).size.width,
                                  constraints: BoxConstraints(
                                    minHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            null;
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 30,
                                                left: 30,
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Primary,
                                                width: 3,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(25),
                                              child: Obx(() => controller
                                                      .loadingDenda.value
                                                  ? CircularProgressIndicator()
                                                  : Column(
                                                    children: [
                                                      Obx(() => controller
                                                                  .selectedImage !=
                                                              null
                                                          ? Container(
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary
                                                                    .withOpacity(
                                                                        0.2),
                                                                border:
                                                                    Border
                                                                        .all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        12),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(12),
                                                                    child:
                                                                        Image(
                                                                      image:
                                                                          Image.file(controller.selectedImage!).image,
                                                                      height:
                                                                          200,
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom:
                                                                        5,
                                                                    right:
                                                                        5,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          38,
                                                                      height:
                                                                          38,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed: () =>
                                                                            controller.pickImage(),
                                                                        style:
                                                                            ElevatedButton.styleFrom(
                                                                          padding: EdgeInsets.all(0),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                          ),
                                                                          child: const Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Icon(
                                                                              Icons.create,
                                                                              color: Colors.white,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .pickImage(),
                                                              child: Obx(() => controller
                                                                      .errorBuktiPembayaran
                                                                      .value
                                                                  ? Container(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          double.infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                                                        border:
                                                                            Border.all(
                                                                          color: Theme.of(context).errorColor,
                                                                          width: 2,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.photo_library,
                                                                            size: 80,
                                                                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                          ),
                                                                          SizedBox(height: 10),
                                                                          Text(
                                                                            "BUKTI PEMBAYARAN",
                                                                            textAlign: TextAlign.center,
                                                                            style: GoogleFonts.getFont(
                                                                              'Poppins',
                                                                              textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 20,
                                                                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          double.infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                                                        border:
                                                                            Border.all(
                                                                          color: Theme.of(context).colorScheme.primary,
                                                                          width: 2,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.photo_library,
                                                                            size: 80,
                                                                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                          ),
                                                                          SizedBox(height: 10),
                                                                          Text(
                                                                            "BUKTI PEMBAYARAN",
                                                                            textAlign: TextAlign.center,
                                                                            style: GoogleFonts.getFont(
                                                                              'Poppins',
                                                                              textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 20,
                                                                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                            )),
                                                      SizedBox(height: 15),
                                                      Obx(() {
                                                        if (controller
                                                            .errorPaymentMethod
                                                            .value) {
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                              border: Border
                                                                  .all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: controller
                                                                        .selectedItem
                                                                        .value
                                                                        .isEmpty
                                                                    ? null
                                                                    : controller
                                                                        .selectedItem
                                                                        .value,
                                                                icon: Icon(
                                                                    Icons
                                                                        .expand_more_rounded,
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .primary),
                                                                hint: Text(
                                                                  'Metode Pembayaran',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .primary,
                                                                    fontWeight:
                                                                        FontWeight.w700,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                                iconSize:
                                                                    28,
                                                                onChanged:
                                                                    (String?
                                                                        newValue) {
                                                                  controller
                                                                      .selectedItem
                                                                      .value = newValue!;
                                                                },
                                                                items: const [
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'CASH',
                                                                    child: Text(
                                                                        'CASH'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'QRIS',
                                                                    child: Text(
                                                                        'QRIS'),
                                                                  ),
                                                                ],
                                                                dropdownColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                                underline:
                                                                    Container(),
                                                                elevation:
                                                                    0,
                                                                isExpanded:
                                                                    true,
                                                                itemHeight:
                                                                    50,
                                                                focusColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                              border: Border
                                                                  .all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value: controller
                                                                        .selectedItem
                                                                        .value
                                                                        .isEmpty
                                                                    ? null
                                                                    : controller
                                                                        .selectedItem
                                                                        .value,
                                                                icon: Icon(
                                                                    Icons
                                                                        .expand_more_rounded,
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .primary),
                                                                hint: Text(
                                                                  'Metode Pembayaran',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .primary,
                                                                    fontWeight:
                                                                        FontWeight.w700,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                                iconSize:
                                                                    28,
                                                                onChanged:
                                                                    (String?
                                                                        newValue) {
                                                                  controller
                                                                      .selectedItem
                                                                      .value = newValue!;
                                                                },
                                                                items: const [
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'CASH',
                                                                    child: Text(
                                                                        'CASH'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        'QRIS',
                                                                    child: Text(
                                                                        'QRIS'),
                                                                  ),
                                                                ],
                                                                dropdownColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                                underline:
                                                                    Container(),
                                                                elevation:
                                                                    0,
                                                                isExpanded:
                                                                    true,
                                                                itemHeight:
                                                                    50,
                                                                focusColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                      SizedBox(height: 25),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Danger,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () {
                                                                controller
                                                                    .isVisible(
                                                                        false);
                                                                controller
                                                                    .errorBuktiPembayaran(
                                                                        false);
                                                                controller
                                                                    .errorPaymentMethod(
                                                                        false);
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors.transparent),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  0,
                                                                ),
                                                                shape:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  SizedBox(
                                                                width: 60,
                                                                child:
                                                                    Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child:
                                                                      Text(
                                                                    "Batal",
                                                                    textAlign:
                                                                        TextAlign.center,
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Poppins',
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Success,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                controller
                                                                    .lunasiDenda();
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors.transparent),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(0),
                                                                shape:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  SizedBox(
                                                                width: 60,
                                                                child:
                                                                    Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child:
                                                                      Text(
                                                                    "Simpan",
                                                                    textAlign:
                                                                        TextAlign.center,
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Poppins',
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null)),
                ],
              );
            } else {
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
            }
          }),
        ),
      ),
    );
  }
}

String formatCurrency(int amount) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return currencyFormat.format(amount);
}

void _showDendaConfirmationDialog(
    BuildContext context, String username, String denda) {
  final ScanController scanController = Get.find<ScanController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'LUNASI DENDA',
          style: GoogleFonts.bebasNeue(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
              fontSize: 34),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          'Apakah anda yakin $username sudah membayar denda sebesar $denda',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Danger),
            ),
            child: Text(
              'Tidak',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Success),
            ),
            child: Text(
              'Ya',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class ShimmerGroup extends StatelessWidget {
  const ShimmerGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Shimmers(
              height: 300,
            ),
          ),
          SizedBox(height: 35),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Shimmers(width: 100, height: 45)),
                SizedBox(width: 30),
                Expanded(child: Shimmers(width: 100, height: 45)),
              ],
            ),
          ),
        ],
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

// _showDendaConfirmationDialog(
// context,
// controller.dataBorrowBook.value['users']
// ['username'],
// formatCurrency(controller
//     .dataBorrowBook.value['denda'])),