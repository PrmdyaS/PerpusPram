import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/pdf/LaporanPeminjaman.dart';

import '../controllers/laporan_peminjaman_controller.dart';

class LaporanPeminjamanView extends GetView<LaporanPeminjamanController> {
  const LaporanPeminjamanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LaporanPeminjaman laporanPeminjaman = LaporanPeminjaman();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan Peminjaman',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          value: controller.selectedItem.value.isEmpty
                              ? null
                              : controller.selectedItem.value,
                          icon: Icon(Icons.expand_more_rounded,
                              color: Theme.of(context).colorScheme.primary),
                          hint: Text(
                            'Sortir',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).colorScheme.primary,
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
                          focusColor: Theme.of(context).colorScheme.background,
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
                    horizontalMargin: MediaQuery.of(context).size.width / 20,
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
                          'Judul Buku',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tanggal Pinjam',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tanggal Kembali',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
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
      floatingActionButton: Obx(() => controller.loading.value
          ? Container()
          : Container(
              margin: EdgeInsets.only(right: 15, bottom: 15, top: 25),
              child: ElevatedButton(
                onPressed: () async {
                  final data =
                      await laporanPeminjaman.generateLaporanPeminjaman(
                          controller.borrowBookList,
                          controller.subtitleLaporan.value);
                  laporanPeminjaman.savePdfFile("Laporan Peminjaman", data);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ).copyWith(
                  backgroundColor: MaterialStateProperty.all(
                      Danger),
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
            )),
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
  LaporanPeminjamanController controller =
      Get.find<LaporanPeminjamanController>();

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
        '${borrowBook.books != null ? borrowBook.books!.judul : "Buku sudah dihapus!"}',
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
        formatDate('${borrowBook.borrowingDate}'),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        formatDate('${borrowBook.returnDate}'),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
      DataCell(Text(
        '${borrowBook.status}',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.borrowBookList.length;

  @override
  int get selectedRowCount => 0;
}
