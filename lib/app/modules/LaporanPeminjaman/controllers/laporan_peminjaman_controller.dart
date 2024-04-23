import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_borrow_book.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

class LaporanPeminjamanController extends GetxController {
  final loading = false.obs;
  RxList<BorrowBook> borrowBookAllList = <BorrowBook>[].obs;
  var borrowBookList = <BorrowBook>[];
  var itemsPerPage = 5;
  var currentPage = 0;
  var selectedItem = 'All'.obs;
  var subtitleLaporan = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    loading(true);
    try {
      final response =
          await ApiProvider.instance().get(Endpoint.laporanPeminjaman);
      if (response.statusCode == 200) {
        final List<BorrowBook> books = (response.data['data'] as List)
            .map((json) => BorrowBook.fromJson(json))
            .toList();
        borrowBookAllList.assignAll(books);
        filterData();
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
          getData();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  void paginate() {
    currentPage++;
    fetchData();
  }

  void fetchData() {}

  void filterData() {
    switch (selectedItem.value) {
      case 'All':
        subtitleLaporan.value = 'Seluruh Periode';
        borrowBookList = borrowBookAllList;
        break;
      case 'Hari Ini':
        String hariIni = '${DateTime.now()}';
        subtitleLaporan.value = 'Periode ${formatDate(hariIni)}';
        borrowBookList = borrowBookAllList
            .where((book) => isToday('${book.borrowingDate}'))
            .toList();
        break;
      case 'Kemarin':
        String kemarin = '${DateTime.now().subtract(const Duration(days: 1))}';
        subtitleLaporan.value = 'Periode ${formatDate(kemarin)}';
        borrowBookList = borrowBookAllList
            .where((book) => isYesterday('${book.borrowingDate}'))
            .toList();
        break;
      case 'Minggu Ini':
        DateTime hariIni = DateTime.now();
        int hariDalamSeminggu = 7;
        int hariIniIndex = hariIni.weekday;
        DateTime tanggalAwalMingguIni = hariIni.subtract(Duration(days: hariIniIndex - 1));
        DateTime tanggalAkhirMingguIni = tanggalAwalMingguIni.add(Duration(days: hariDalamSeminggu - 1));
        String tanggal1 = '$tanggalAwalMingguIni';
        String tanggal2 = '$tanggalAkhirMingguIni';
        subtitleLaporan.value = 'Periode ${formatDate(tanggal1)} sampai ${formatDate(tanggal2)}';
        borrowBookList = borrowBookAllList
            .where((book) => isThisWeek('${book.borrowingDate}'))
            .toList();
        break;
      case 'Minggu Lalu':
        DateTime hariIni = DateTime.now();
        int hariDalamSeminggu = 7;
        int hariIniIndex = hariIni.weekday;
        DateTime tanggalAwalMingguIni = hariIni.subtract(Duration(days: hariIniIndex - 1));
        DateTime tanggalAwalMingguLalu = tanggalAwalMingguIni.subtract(Duration(days: hariDalamSeminggu));
        DateTime tanggalAkhirMingguLalu = tanggalAwalMingguIni.subtract(const Duration(days: 1));
        String tanggal1 = '$tanggalAwalMingguLalu';
        String tanggal2 = '$tanggalAkhirMingguLalu';
        subtitleLaporan.value = 'Periode ${formatDate(tanggal1)} sampai ${formatDate(tanggal2)}';
        borrowBookList = borrowBookAllList
            .where((book) => isLastWeek('${book.borrowingDate}'))
            .toList();
        break;
      case 'Bulan Ini':
        DateTime tanggalHariIni = DateTime.now();
        String namaBulan = DateFormat.MMMM('id').format(tanggalHariIni);
        subtitleLaporan.value = 'Periode Bulan $namaBulan';
        borrowBookList = borrowBookAllList
            .where((book) => isThisMonth('${book.borrowingDate}'))
            .toList();
        break;
      case 'Bulan Lalu':
        DateTime tanggalHariIni = DateTime.now();
        DateTime tanggalBulanLalu = DateTime(tanggalHariIni.year, tanggalHariIni.month - 1, tanggalHariIni.day);
        String namaBulanLalu = DateFormat.MMMM('id').format(tanggalBulanLalu);
        subtitleLaporan.value = 'Periode Bulan $namaBulanLalu';
        borrowBookList = borrowBookAllList
            .where((book) => isLastMonth('${book.borrowingDate}'))
            .toList();
        break;
      case 'Tahun Ini':
        String tahunIni = '${DateTime.now().year}';
        subtitleLaporan.value = 'Periode Tahun $tahunIni';
        borrowBookList = borrowBookAllList
            .where((book) => isThisYear('${book.borrowingDate}'))
            .toList();
        break;
      case 'Tahun Lalu':
        String tahunLalu = '${DateTime.now().year - 1}';
        subtitleLaporan.value = 'Periode Tahun $tahunLalu';
        borrowBookList = borrowBookAllList
            .where((book) => isLastYear('${book.borrowingDate}'))
            .toList();
        break;
      default:
        break;
    }
  }

  bool isToday(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isYesterday(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  bool isThisWeek(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int weekNumberDate = date.difference(DateTime(date.year, 1, 1)).inDays ~/ 7;
    int weekNumberNow = now.difference(DateTime(date.year, 1, 1)).inDays ~/ 7;
    weekNumberDate++;
    weekNumberNow++;
    return date.year == now.year && weekNumberDate == weekNumberNow;
  }

  bool isLastWeek(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int weekNumberDate = date.difference(DateTime(date.year, 1, 1)).inDays ~/ 7;
    int weekNumberNow = (now.difference(DateTime(date.year, 1, 1)).inDays ~/ 7);
    weekNumberDate++;
    weekNumberNow++;
    return now.year == date.year && (weekNumberNow - weekNumberDate == 1);
  }

  bool isThisMonth(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isLastMonth(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month - 1);
    return date.year == lastMonth.year && date.month == lastMonth.month;
  }

  bool isThisYear(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year;
  }

  bool isLastYear(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime lastYear = DateTime(now.year - 1);
    return date.year == lastYear.year;
  }

  String formatDate(String dateString) {
    if (dateString != '') {
      DateTime date = DateTime.parse(dateString);
      DateFormat formatter = DateFormat('dd MMMM yyyy', 'id');
      return formatter.format(date);
    }
    return '';
  }
}
