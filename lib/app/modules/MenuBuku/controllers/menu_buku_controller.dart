import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:perpus_pram/app/data/constant/endpoint.dart';
import 'package:perpus_pram/app/data/model/response_book.dart';
import 'package:perpus_pram/app/data/provider/api_provider.dart';

class MenuBukuController extends GetxController {
  var bookList = <DataBook>[].obs;
  final loading = false.obs;
  final loadingPost = false.obs;
  final loadingUpdate = false.obs;
  final loadingGenre = false.obs;
  final loadingSubCategories = false.obs;
  var isAddVisible = false.obs;
  var isUpdateVisible = false.obs;
  var selectedItem = ''.obs;
  var selectedItemUpdate = ''.obs;
  var msg = ''.obs;
  var selectAlert = ''.obs;
  final idBuku = ''.obs;
  final listGenre = <dynamic>[].obs;
  final listSubCategories = <dynamic>[].obs;
  var selectedGenres = [].obs;
  final selectBook = {}.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUpdate = GlobalKey<FormState>();
  TextEditingController judulController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController tahunTerbitController = TextEditingController();
  TextEditingController deskripsiBukuController = TextEditingController();
  TextEditingController judulUpdateController = TextEditingController();
  TextEditingController penulisUpdateController = TextEditingController();
  TextEditingController penerbitUpdateController = TextEditingController();
  TextEditingController tahunTerbitUpdateController = TextEditingController();
  TextEditingController deskripsiBukuUpdateController = TextEditingController();
  var selectedImages = Rx<File?>(null);
  File? get selectedImage => selectedImages.value;
  var imagePath = ''.obs;
  var errorSampul = false.obs;
  var errorKategori = false.obs;
  var errorGenre = false.obs;
  var errorGenreUpdate = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    getDataGenre();
    getDataSubCategories();
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
      final response = await ApiProvider.instance().get(Endpoint.menuBooks);
      if (response.statusCode == 200) {
        final List<DataBook> books = (response.data['data'] as List)
            .map((json) => DataBook.fromJson(json))
            .toList();
        bookList.assignAll(books);
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

  getDataGenre() async {
    loadingGenre(true);
    try {
      final response = await ApiProvider.instance().get(Endpoint.genres);
      if (response.statusCode == 200) {
        listGenre.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Genre Buku",
            backgroundColor: Colors.orange);
      }
      loadingGenre(false);
    } on DioException catch (e) {
      loadingGenre(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getDataGenre();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingGenre(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getDataSubCategories() async {
    loadingSubCategories(true);
    try {
      final response =
          await ApiProvider.instance().get(Endpoint.subCategoriesList);
      if (response.statusCode == 200) {
        listSubCategories.value = response.data['data'];
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Genre Buku",
            backgroundColor: Colors.orange);
      }
      loadingSubCategories(false);
    } on DioException catch (e) {
      loadingSubCategories(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          getDataSubCategories();
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingSubCategories(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  getSelectBook(String id) async {
    loadingUpdate(true);
    selectedGenres.clear();
    selectedImages.value = null;
    idBuku.value = id;
    try {
      final response =
          await ApiProvider.instance().get("${Endpoint.allBooks}/all/$id");
      if (response.statusCode == 200) {
        selectBook.value = response.data['data'];
        judulUpdateController.text = selectBook['judul'];
        penulisUpdateController.text = selectBook['penulis'];
        penerbitUpdateController.text = selectBook['penerbit'];
        tahunTerbitUpdateController.text = selectBook['tahun_terbit'];
        deskripsiBukuUpdateController.text = selectBook['deskripsi_buku'];
        selectedItemUpdate.value = selectBook['sub_categories']['_id'];
        imagePath.value = selectBook['sampul_buku'];
        for (var genre in selectBook['genres']) {
          selectedGenres.add(genre['_id']);
        }
      } else {
        Get.snackbar("Sorry", "Gagal Memuat Buku",
            backgroundColor: Colors.orange);
      }
      loadingUpdate(false);
    } on DioException catch (e) {
      loadingUpdate(false);
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
      loadingUpdate(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> pickImage() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      selectedImages.value = File(returnImage.path);
    }
  }

  postData() async {
    loadingPost(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate() &&
          selectedImage != null &&
          selectedItem.value != '' &&
          selectedGenres.value.isNotEmpty) {
        dio.FormData formData = dio.FormData.fromMap({
          "judul": judulController.text.toString(),
          "penulis": penulisController.text.toString(),
          "penerbit": penerbitController.text.toString(),
          "tahun_terbit": tahunTerbitController.text.toString(),
          "sub_categories_id": selectedItem.value,
          "genres_id": selectedGenres.value,
          "deskripsi_buku": deskripsiBukuController.text.toString(),
        });
        if (selectedImage != null) {
          formData.files.add(MapEntry(
            'sampul_buku',
            await dio.MultipartFile.fromFile(
              selectedImage!.path,
              filename: "image.jpg",
            ),
          ));
        }
        final response = await ApiProvider.instance().post(
          Endpoint.allBooks,
          data: formData,
        );
        if (response.statusCode == 200) {
          judulController.text = '';
          penulisController.text = '';
          penerbitController.text = '';
          tahunTerbitController.text = '';
          deskripsiBukuController.text = '';
          selectedItem.value = '';
          selectedGenres.clear();
          selectedImages.value = null;
          selectAlert.value = 'success';
          msg.value = 'Kamu berhasil melakukan tambah buku!';
          getData();
          isAddVisible(false);
        } else {
          Get.snackbar("Sorry", "Update gagal", backgroundColor: Colors.orange);
        }
      } else {
        if (selectedImage == null) {
          errorSampul(true);
        }
        if (selectedItem.value == '') {
          errorKategori(true);
        }
        if (selectedGenres.value.isEmpty) {
          errorGenre(true);
        }
      }
      loadingPost(false);
    } on dio.DioError catch (e) {
      loadingPost(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Error", "${e.response}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Error", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingPost(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      loadingPost(false);
    }
  }

  updateData() async {
    loadingUpdate(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKeyUpdate.currentState?.save();
      if (formKeyUpdate.currentState!.validate() &&
          selectedGenres.value.isNotEmpty) {
        dio.FormData formData = dio.FormData.fromMap({
          "judul": judulUpdateController.text.toString(),
          "penulis": penulisUpdateController.text.toString(),
          "penerbit": penerbitUpdateController.text.toString(),
          "tahun_terbit": tahunTerbitUpdateController.text.toString(),
          "sub_categories_id": selectedItemUpdate.value,
          "genres_id": selectedGenres.value,
          "deskripsi_buku": deskripsiBukuUpdateController.text.toString(),
        });
        if (selectedImage != null) {
          if (selectedImage != null) {
            formData.files.add(MapEntry(
              'sampul_buku',
              await dio.MultipartFile.fromFile(
                selectedImage!.path,
                filename: "image.jpg",
              ),
            ));
          }
        }
        final response = await ApiProvider.instance().patch(
          '${Endpoint.allBooks}/${idBuku.value}',
          data: formData,
        );
        if (response.statusCode == 200) {
          isUpdateVisible(false);
          getData();
          selectAlert.value = 'success';
          msg.value = 'Kamu berhasil melakukan update buku!';
        } else {
          Get.snackbar("Sorry", "Update gagal", backgroundColor: Colors.orange);
        }
      } else {
        if (selectedGenres.value.isEmpty) {
          errorGenreUpdate(true);
        }
      }
      loadingUpdate(false);
    } on dio.DioError catch (e) {
      loadingUpdate(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Error", "${e.response}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Error", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUpdate(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      loadingUpdate(false);
    }
  }

  deleteData(String id) async {
    loadingUpdate(true);
    try {
      final response = await ApiProvider.instance().delete(
        '${Endpoint.allBooks}/$id'
      );
      if (response.statusCode == 200) {
        getData();
      } else {
        Get.snackbar("Sorry", "Delete gagal", backgroundColor: Colors.orange);
      }
    } on dio.DioError catch (e) {
      loadingUpdate(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Error", "${e.response}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Error", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loadingUpdate(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      loadingUpdate(false);
    }
  }
}
