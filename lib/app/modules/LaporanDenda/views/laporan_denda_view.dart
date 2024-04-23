import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/pdf/LaporanDenda.dart';
import 'package:perpus_pram/app/data/pdf/LaporanPeminjaman.dart';

import '../controllers/laporan_denda_controller.dart';

class LaporanDendaView extends GetView<LaporanDendaController> {
  const LaporanDendaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LaporanDenda laporanDenda = LaporanDenda();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan Denda',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(() => controller.loading.value
                ? Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Center(child: CircularProgressIndicator()))
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, bottom: 10, top: 10),
                            width: 130,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: Primary,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                value: controller.selectedItem.value.isEmpty
                                    ? null
                                    : controller.selectedItem.value,
                                icon: Icon(Icons.expand_more_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                hint: Text(
                                  'Sortir',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                iconSize: 20,
                                onChanged: (String? newValue) {
                                  controller.selectedItem.value = newValue!;
                                  controller.filterData();
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: "All",
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Hari Ini",
                                    child: Text(
                                      "Hari Ini",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Kemarin",
                                    child: Text(
                                      "Kemarin",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Minggu Ini",
                                    child: Text(
                                      "Minggu Ini",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Minggu Lalu",
                                    child: Text(
                                      "Minggu Lalu",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Bulan Ini",
                                    child: Text(
                                      "Bulan Ini",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Bulan Lalu",
                                    child: Text(
                                      "Bulan Lalu",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Tahun Ini",
                                    child: Text(
                                      "Tahun Ini",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Tahun Lalu",
                                    child: Text(
                                      "Tahun Lalu",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                                dropdownColor:
                                    Theme.of(context).colorScheme.background,
                                underline: Container(),
                                elevation: 0,
                                isExpanded: true,
                                focusColor:
                                    Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        child: PaginatedDataTable(
                          columnSpacing: MediaQuery.of(context).size.width / 10,
                          horizontalMargin:
                              MediaQuery.of(context).size.width / 20,
                          headingRowColor: MaterialStatePropertyAll(Primary),
                          rowsPerPage: 10,
                          columns: const [
                            DataColumn(
                              label: Text(
                                'No',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Metode Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Pembayar Denda',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Waktu Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Penerima Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Bukti Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                          source: _DataSource(controller),
                          showCheckboxColumn: false,
                        ),
                      ),
                    ],
                  )),
            Obx(() => AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: controller.isImageShowed.value ? 1.0 : 0.0,
                child: controller.isImageShowed.value
                    ? GestureDetector(
                        onTap: () {
                          controller.isImageShowed(false);
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      controller.imageValue.value,
                                      width: 300,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.isImageShowed(false);
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
        ),
      ),
      floatingActionButton: Obx(() => controller.loading.value
          ? Container()
          : Obx(() => controller.isImageShowed.value
              ? Container()
              : Container(
                  margin: EdgeInsets.only(right: 15, bottom: 15, top: 25),
                  child: ElevatedButton(
                    onPressed: () async {
                      final data = await laporanDenda.generateLaporanDenda(
                          controller.borrowBookList,
                          controller.subtitleLaporan.value);
                      laporanDenda.savePdfFile("Laporan Denda", data);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.all(Danger),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Print PDF",
                          style: GoogleFonts.getFont(
                            'Poppins',
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        const Icon(Icons.save, color: Colors.white, size: 15),
                      ],
                    ),
                  ),
                ))),
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

class _DataSource extends DataTableSource {
  LaporanDendaController controller = Get.find<LaporanDendaController>();

  _DataSource(this.controller);

  @override
  DataRow getRow(int index) {
    final borrowBook = controller.borrowBookList[index];
    return DataRow(cells: [
      DataCell(Text(
        '${index + 1}. ',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        '${borrowBook.dendas!.paymentMethod}',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        '${borrowBook.users!.username}',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        formatDate('${borrowBook.dendas!.paymentDate}'),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        '${borrowBook.dendas!.officer!.username}',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(
        GestureDetector(
          onTap: () {
            controller.imageValue.value =
                '${borrowBook.dendas!.buktiPembayaran}';
            controller.isImageShowed(true);
          },
          child: Image.network(
            '${borrowBook.dendas!.buktiPembayaran}',
            width: 22,
          ),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.borrowBookList.length;

  @override
  int get selectedRowCount => 0;
}
