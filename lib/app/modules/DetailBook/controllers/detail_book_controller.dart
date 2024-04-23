import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';
import 'package:perpus_pram/app/data/provider/storage_provider.dart';
import 'package:perpus_pram/app/modules/ListBook/controllers/list_book_controller.dart';

class DetailBookController extends GetxController {
  var showBottomNavBar = true.obs;
  var isDateShowed = false.obs;
  var isQRShowed = false.obs;
  var rekomendasiBookList = <DataBook>[].obs;
  final selectBook = {}.obs;
  final listUlasanAnda = <dynamic>[].obs;
  final listUlasan = <dynamic>[].obs;
  final loadingData = false.obs;
  final loadingRekomendasi = false.obs;
  final loadingFavorite = false.obs;
  final loadingAddPeminjaman = false.obs;
  final loadingUlasanAnda = false.obs;
  final loadingUlasan = false.obs;
  final addFavorite = false.obs;
  String? penerbit;
  String? bookId;
  final endpointRekomendasi = ''.obs;
  final endpointFavoriteSaya = ''.obs;
  final qrValue = ''.obs;
  var status = "".obs;
  var userId = "".obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tanggalPinjamController = TextEditingController();
  // final TextEditingController tanggalKembaliController =
  //     TextEditingController();
  var expandedReview = false.obs;
  var count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // if (Get.parameters['function'] != null &&
    //     Get.parameters['function'] == "addToFavorite") {
    //   addToFavorite();
    // } else if (Get.parameters['function'] != null &&
    //     Get.parameters['function'] == "pinjam") {
    //   isDateShowed(true);
    //   showBottomNavBar(false);
    // }
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
    // if (Get.parameters['function'] != null &&
    //     Get.parameters['function'] == "showQRCode") {
    //   isDateShowed(false);
    //   showBottomNavBar(false);
    //   isQRShowed(true);
    //   QRValue.value = '${Get.parameters['id_borrow_book']}';
    // }
  }

  @override
  void onClose() async {
    super.onClose();
    await StorageProvider.writeBool(StorageKey.refreshPeminjaman, true);
    if (Get.parameters['title'] == 'Favorit Saya') {
      final previousPageController = Get.find<ListBookController>();
      previousPageController.getData();
    }
  }

  getStorageData() async {
    status.value = StorageProvider.read(StorageKey.status) ?? "";
    userId.value = StorageProvider.read(StorageKey.idUser) ?? "";
  }

  getData() async {
    loadingData(true);
    try {
      final response = await ApiProvider.instance()
          .get("${Endpoint.allBooks}/${Get.arguments['id']}");
      if (response.statusCode == 200) {
        selectBook.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loadingData(false);
    } on DioException catch (e) {
      loadingData(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getData();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingData(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getDataRekomendasi() async {
    loadingRekomendasi(true);
    try {
      endpointRekomendasi.value = '${Endpoint.allBooks}?penerbit=$penerbit';
      final responseRekomendasi =
          await ApiProvider.instance().get(endpointRekomendasi.value);
      if (responseRekomendasi.statusCode == 200) {
        final List<DataBook> booksRekomendasi =
            (responseRekomendasi.data['data'] as List)
                .map((json) => DataBook.fromJson(json))
                .toList();
        rekomendasiBookList.assignAll(booksRekomendasi);
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loadingRekomendasi(false);
    } on DioException catch (e) {
      loadingRekomendasi(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getDataRekomendasi();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingRekomendasi(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getDataFavorite() async {
    if (userId.value != "") {
      try {
        loadingFavorite(true);
        endpointFavoriteSaya.value =
            '${Endpoint.favoriteSaya}?books_id=$bookId&users_id=$userId';
        final responseFavorite =
            await ApiProvider.instance().get(endpointFavoriteSaya.value);
        if (responseFavorite.statusCode == 200) {
          if (responseFavorite.data['data'].isEmpty) {
            addFavorite(false);
          } else {
            addFavorite(true);
          }
        } else {
          Get.snackbar("Sorry", "Gagal Memuat Buku",
              backgroundColor: Colors.orange);
        }
        loadingFavorite(false);
      } on DioException catch (e) {
        loadingFavorite(false);
        if (e.response != null) {
          if (e.response?.data != null) {
            getDataFavorite();
          }
        } else {
          Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
        }
      } catch (e) {
        loadingFavorite(false);
        Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      }
    }
  }

  getDataUlasanAnda(String userIds, String booksIds) async {
    loadingUlasanAnda(true);
    try {
      final response = await ApiProvider.instance().get(
          '${Endpoint.reviewsUsersBooks}?users_id=$userIds&books_id=$booksIds');
      if (response.statusCode == 200) {
        listUlasanAnda.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Ulasan Buku",
            backgroundColor: Colors.orange);
      }
      loadingUlasanAnda(false);
    } on DioException catch (e) {
      loadingUlasanAnda(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getDataUlasanAnda(userId.value, Get.arguments['id']);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUlasanAnda(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getDataUlasan() async {
    loadingUlasan(true);
    try {
      final response = await ApiProvider.instance()
          .get('${Endpoint.reviews}books/${Get.arguments['id']}');
      if (response.statusCode == 200) {
        listUlasan.value = response.data['data'];
        if (listUlasan.length < 3) {
          count.value = listUlasan.length;
        } else {
          count.value = 3;
        }
      } else {
        Get.snackbar("Sorry", "Gagal Ulasan Buku",
            backgroundColor: Colors.orange);
      }
      loadingUlasan(false);
    } on DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getDataUlasan();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUlasan(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  addToFavorite() async {
    loadingFavorite(true);
    try {
      final responseAddToFavorite =
          await ApiProvider.instance().post(Endpoint.favoriteSaya, data: {
        "books_id": bookId,
        "users_id": userId.value,
      });
      if (responseAddToFavorite.statusCode == 200) {
        addFavorite(true);
        Fluttertoast.showToast(
          msg: "Berhasil menambahkan ke favorit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Primary,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (responseAddToFavorite.statusCode == 201) {
        await ApiProvider.instance().delete(
            '${Endpoint.favoriteSaya}/${responseAddToFavorite.data['data']['_id']}');
        addFavorite(false);
        Fluttertoast.showToast(
          msg: "Hapus buku dari favorit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Primary,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Get.snackbar("Sorry", "Register Gagal", backgroundColor: Colors.orange);
      }
      loadingFavorite(false);
    } on DioException catch (e) {
      loadingFavorite(false);
      if (e.response != null) {
        if (e.response?.data != null) {
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingFavorite(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  addPeminjaman(String booksId) async {
    loadingAddPeminjaman(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response =
            await ApiProvider.instance().post(Endpoint.borrowBooks, data: {
          "users_id": StorageProvider.read(StorageKey.idUser).toString(),
          "books_id": booksId.toString(),
          "borrowing_date": tanggalPinjamController.text.toString(),
          "return_date": DateTime.parse(tanggalPinjamController.text).add(const Duration(days: 7)).toString().substring(0, 10),
        });
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Kamu berhasil meminjam buku",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Primary,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          final Map<String, dynamic> data = response.data;
          final String insertedId = data['data']['insertedId'];
          isDateShowed(false);
          showBottomNavBar(false);
          isQRShowed(true);
          qrValue.value = insertedId;
          // Get.offAllNamed(Routes.ALL_PAGE, parameters: {
          //   'page': '0',
          //   'login': 'login',
          //   'function': 'showQRCode',
          //   'open_page': 'detailbukuQRCode',
          //   'id_borrow_book': insertedId,
          //   'id': '${Get.parameters['id']}',
          //   'judul': '${Get.parameters['judul']}',
          //   'penulis': '${Get.parameters['penulis']}',
          //   'penerbit': '${Get.parameters['penerbit']}',
          //   'sampul_buku': '${Get.parameters['sampul_buku']}',
          //   'rating': '${Get.parameters['rating']}',
          // });
        } else {
          Get.snackbar("Sorry", "Tambah Pinjam Gagal",
              backgroundColor: Colors.orange);
        }
      }
      loadingAddPeminjaman(false);
    } on DioException catch (e) {
      loadingAddPeminjaman(false);
      if (e.response != null) {
        if (e.response?.data != null) {
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingAddPeminjaman(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  fetchData() {
    print("plsjawa");
    print("${Get.arguments['id']}");
    if (Get.arguments['id'] != null) {
      penerbit = Get.arguments['penerbit'];
      bookId = Get.arguments['id'];
    }
    getStorageData();
    getDataFavorite();
    getData();
    getDataRekomendasi();
    getDataUlasanAnda(userId.value, Get.arguments['id']);
    getDataUlasan();
  }
}
