import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/menu_buku_controller.dart';

class MenuBukuView extends GetView<MenuBukuController> {
  const MenuBukuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Buku',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(() => controller.loading.value
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Shimmers(
                        height: 200,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.bookList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${controller.bookList[index].judul}",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        "${controller.bookList[index].penulis}",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.9),
                          ),
                        ),
                      ),
                      leading: Image.network(
                        "${controller.bookList[index].sampulBuku}",
                      ),
                      trailing: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 38,
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.getSelectBook(
                                      "${controller.bookList[index].id}");
                                  controller.isUpdateVisible(true);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color:
                                          Colors.yellowAccent.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.mode_edit_outline_rounded,
                                      color: Colors.yellowAccent,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 38,
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.selectAlert.value = 'delete';
                                  controller.msg.value = 'Apakah kamu yakin akan menghapus ${controller.bookList[index].judul}?';
                                  controller.idBuku.value = '${controller.bookList[index].id}';
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.redAccent.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          Obx(() {
            if (controller.msg.value == '') {
              return Container();
            } else {
              if (controller.selectAlert.value == 'success') {
                return AlertDialog(
                  title: Text(
                    'Berhasil',
                    style: GoogleFonts.bebasNeue(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  content: Text(
                    controller.msg.value,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        controller.msg.value = '';
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
                );
              } else if (controller.selectAlert.value == 'delete') {
                return AlertDialog(
                  title: Text(
                    'Delete',
                    style: GoogleFonts.bebasNeue(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  content: Text(
                    controller.msg.value,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        controller.msg.value = '';
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Danger),
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
                        controller.msg.value = '';
                        controller.deleteData(controller.idBuku.value);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Success),
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
              } else {
                return Container();
              }
            }
          }),
          Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: controller.isUpdateVisible.value ? 1.0 : 0.0,
              child: controller.isUpdateVisible.value
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GestureDetector(
                        onTap: () {
                          controller.isUpdateVisible(false);
                          controller.selectedImages.value = null;
                          controller.errorGenreUpdate(false);
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                null;
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 30, left: 30, bottom: 20),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Primary,
                                    width: 3,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Obx(() => controller
                                          .loadingUpdate.value
                                      ? CircularProgressIndicator()
                                      : Form(
                                          key: controller.formKeyUpdate,
                                          child: Column(
                                            children: [
                                              Obx(() {
                                                if (controller.selectedImage !=
                                                    null) {
                                                  return Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.2),
                                                      border: Border.all(
                                                        color: Theme.of(context)
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
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image(
                                                            image: Image.file(
                                                                    controller
                                                                        .selectedImage!)
                                                                .image,
                                                            height: 200,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 5,
                                                          right: 5,
                                                          child: SizedBox(
                                                            width: 38,
                                                            height: 38,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () =>
                                                                  controller
                                                                      .pickImage(),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                              ),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .create,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else if (controller.imagePath
                                                    .value.isNotEmpty) {
                                                  return Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.2),
                                                      border: Border.all(
                                                        color: Theme.of(context)
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
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image(
                                                            image: NetworkImage(
                                                                controller
                                                                    .imagePath
                                                                    .value),
                                                            height: 200,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 5,
                                                          right: 5,
                                                          child: SizedBox(
                                                            width: 38,
                                                            height: 38,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () =>
                                                                  controller
                                                                      .pickImage(),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                              ),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .create,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  return GestureDetector(
                                                    onTap: () =>
                                                        controller.pickImage(),
                                                    child: Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.2),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.photo_library,
                                                            size: 80,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            "SAMPUL BUKU",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              textStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 20,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: controller
                                                      .judulUpdateController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Judul Buku',
                                                    labelStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                    hintText:
                                                        'Masukkan Judul Buku',
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8)),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Primary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Judul tidak boleh kosong!";
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: controller
                                                      .penulisUpdateController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Penulis Buku',
                                                    labelStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                    hintText:
                                                        'Masukkan Penulis Buku',
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8)),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Primary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Penulis tidak boleh kosong!";
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: controller
                                                      .penerbitUpdateController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Penerbit Buku',
                                                    labelStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                    hintText:
                                                        'Masukkan Penerbit Buku',
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8)),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Primary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Penerbit tidak boleh kosong!";
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: controller
                                                      .tahunTerbitUpdateController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Tahun Terbit Buku',
                                                    labelStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                    hintText:
                                                        'Masukkan Tahun Terbit Buku',
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8)),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Primary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Tahun terbit tidak boleh kosong!";
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  controller: controller
                                                      .deskripsiBukuUpdateController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Deskripsi Buku',
                                                    labelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                    ),
                                                    hintText:
                                                        'Masukkan Deskripsi Buku',
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8)),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Primary,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Deskripsi buku tidak boleh kosong!";
                                                    }
                                                    return null;
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Obx(() => controller
                                                      .loadingSubCategories
                                                      .value
                                                  ? Container()
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: controller
                                                                  .selectedItemUpdate
                                                                  .value
                                                                  .isEmpty
                                                              ? null
                                                              : controller
                                                                  .selectedItemUpdate
                                                                  .value,
                                                          icon: Icon(
                                                              Icons
                                                                  .expand_more_rounded,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                          hint: Text(
                                                            'Kategori Buku',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          iconSize: 28,
                                                          onChanged: (String?
                                                              newValue) {
                                                            controller
                                                                .selectedItemUpdate
                                                                .value = newValue!;
                                                          },
                                                          items: controller
                                                              .listSubCategories
                                                              .map(
                                                                  (subcategory) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  subcategory[
                                                                      "_id"],
                                                              child: Text(
                                                                  subcategory[
                                                                      "sub_categories_name"]),
                                                            );
                                                          }).toList(),
                                                          dropdownColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .background,
                                                          underline:
                                                              Container(),
                                                          elevation: 0,
                                                          isExpanded: true,
                                                          itemHeight: 50,
                                                          focusColor: Theme.of(context).colorScheme.background,
                                                        ),
                                                      ),
                                                    )),
                                              SizedBox(height: 15),
                                              Obx(() =>
                                                  controller.loadingGenre.value
                                                      ? Container()
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Obx(() => controller
                                                                      .errorGenreUpdate
                                                                      .value
                                                                  ? Text(
                                                                      'Genre Buku',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Theme.of(context)
                                                                            .errorColor,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      'Genre Buku',
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
                                                                    )),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Wrap(
                                                                runSpacing: 8,
                                                                spacing: 8,
                                                                children: List.generate(
                                                                    controller
                                                                        .listGenre
                                                                        .length,
                                                                    (index) {
                                                                  return CustomButton(
                                                                    listGenre:
                                                                        controller
                                                                            .listGenre[index],
                                                                  );
                                                                }),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                              SizedBox(height: 25),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Danger,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        controller
                                                            .isUpdateVisible(
                                                                false);
                                                        controller
                                                            .selectedImages
                                                            .value = null;
                                                        controller
                                                            .errorGenreUpdate(
                                                                false);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .transparent),
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
                                                                BorderRadius
                                                                    .circular(
                                                              8,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        width: 60,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            "Batal",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              textStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Success,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        controller.updateData();
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .transparent),
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(0),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        width: 60,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            "Simpan",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              textStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
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
                                          ),
                                        )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null)),
          Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: controller.isAddVisible.value ? 1.0 : 0.0,
              child: controller.isAddVisible.value
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GestureDetector(
                        onTap: () {
                          controller.isAddVisible(false);
                          controller.errorSampul(false);
                          controller.errorKategori(false);
                          controller.errorGenre(false);
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    null;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 30, left: 30, bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Primary,
                                        width: 3,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Obx(() => controller
                                              .loadingPost.value
                                          ? CircularProgressIndicator()
                                          : Form(
                                              key: controller.formKey,
                                              child: Column(
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
                                                            border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                child: Image(
                                                                  image: Image.file(
                                                                          controller
                                                                              .selectedImage!)
                                                                      .image,
                                                                  height: 200,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 5,
                                                                right: 5,
                                                                child: SizedBox(
                                                                  width: 38,
                                                                  height: 38,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed: () =>
                                                                        controller
                                                                            .pickImage(),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                      ),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .create,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              20,
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
                                                          child: Obx(() =>
                                                              controller
                                                                      .errorSampul
                                                                      .value
                                                                  ? Container(
                                                                      height:
                                                                          200,
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .secondary
                                                                            .withOpacity(0.2),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Theme.of(context).errorColor,
                                                                          width:
                                                                              2,
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
                                                                            size:
                                                                                80,
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            "SAMPUL BUKU",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                GoogleFonts.getFont(
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
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .secondary
                                                                            .withOpacity(0.2),
                                                                        border:
                                                                            Border.all(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primary,
                                                                          width:
                                                                              2,
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
                                                                            size:
                                                                                80,
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            "SAMPUL BUKU",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                GoogleFonts.getFont(
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
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: controller
                                                          .judulController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Judul Buku',
                                                        labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18),
                                                        hintText:
                                                            'Masukkan Judul Buku',
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.8)),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.transparent,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      Primary,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Judul tidak boleh kosong!";
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: controller
                                                          .penulisController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Penulis Buku',
                                                        labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18),
                                                        hintText:
                                                            'Masukkan Penulis Buku',
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.8)),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.transparent,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      Primary,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Penulis tidak boleh kosong!";
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: controller
                                                          .penerbitController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Penerbit Buku',
                                                        labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18),
                                                        hintText:
                                                            'Masukkan Penerbit Buku',
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.8)),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.transparent,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      Primary,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Penerbit tidak boleh kosong!";
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: controller
                                                          .tahunTerbitController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Tahun Terbit Buku',
                                                        labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18),
                                                        hintText:
                                                            'Masukkan Tahun Terbit Buku',
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.8)),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.transparent,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      Primary,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Tahun terbit tidak boleh kosong!";
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      minLines: 1,
                                                      maxLines: 5,
                                                      controller: controller
                                                          .deskripsiBukuController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Deskripsi Buku',
                                                        labelStyle: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18,
                                                        ),
                                                        hintText:
                                                            'Masukkan Deskripsi Buku',
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.8)),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.transparent,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      Primary,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Deskripsi tidak boleh kosong!";
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Obx(() {
                                                    if (controller
                                                        .loadingSubCategories
                                                        .value) {
                                                      return Container();
                                                    } else if (controller
                                                        .errorKategori.value) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: DropdownButton<
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            hint: Text(
                                                              'Kategori Buku',
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            iconSize: 28,
                                                            onChanged: (String?
                                                                newValue) {
                                                              controller
                                                                      .selectedItem
                                                                      .value =
                                                                  newValue!;
                                                            },
                                                            items: controller
                                                                .listSubCategories
                                                                .map(
                                                                    (subcategory) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    subcategory[
                                                                        "_id"],
                                                                child: Text(
                                                                    subcategory[
                                                                        "sub_categories_name"]),
                                                              );
                                                            }).toList(),
                                                            dropdownColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                            underline:
                                                                Container(),
                                                            elevation: 0,
                                                            isExpanded: true,
                                                            itemHeight: 50,
                                                            focusColor: Theme.of(context).colorScheme.background,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: DropdownButton<
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            hint: Text(
                                                              'Kategori Buku',
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            iconSize: 28,
                                                            onChanged: (String?
                                                                newValue) {
                                                              controller
                                                                      .selectedItem
                                                                      .value =
                                                                  newValue!;
                                                            },
                                                            items: controller
                                                                .listSubCategories
                                                                .map(
                                                                    (subcategory) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    subcategory[
                                                                        "_id"],
                                                                child: Text(
                                                                    subcategory[
                                                                        "sub_categories_name"]),
                                                              );
                                                            }).toList(),
                                                            dropdownColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                            underline:
                                                                Container(),
                                                            elevation: 0,
                                                            isExpanded: true,
                                                            itemHeight: 50,
                                                            focusColor: Theme.of(context).colorScheme.background,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                  SizedBox(height: 15),
                                                  Obx(
                                                      () =>
                                                          controller
                                                                  .loadingGenre
                                                                  .value
                                                              ? Container()
                                                              : SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Obx(() => controller
                                                                              .errorGenre
                                                                              .value
                                                                          ? Text(
                                                                              'Genre Buku',
                                                                              style: TextStyle(
                                                                                color: Theme.of(context).errorColor,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 18,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              'Genre Buku',
                                                                              style: TextStyle(
                                                                                color: Theme.of(context).colorScheme.primary,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 18,
                                                                              ),
                                                                            )),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Wrap(
                                                                        runSpacing:
                                                                            8,
                                                                        spacing:
                                                                            8,
                                                                        children: List.generate(
                                                                            controller.listGenre.length,
                                                                            (index) {
                                                                          return CustomButton(
                                                                            listGenre:
                                                                                controller.listGenre[index],
                                                                          );
                                                                        }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
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
                                                                  .circular(8),
                                                        ),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            controller
                                                                .isAddVisible(
                                                                    false);
                                                            controller
                                                                .errorSampul(
                                                                    false);
                                                            controller
                                                                .errorKategori(
                                                                    false);
                                                            controller
                                                                .errorGenre(
                                                                    false);
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .transparent),
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
                                                                    BorderRadius
                                                                        .circular(
                                                                  8,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          child: SizedBox(
                                                            width: 60,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Text(
                                                                "Batal",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
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
                                                          color: Success,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            controller
                                                                .postData();
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .transparent),
                                                            elevation:
                                                                MaterialStateProperty
                                                                    .all(0),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                          child: SizedBox(
                                                            width: 60,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Text(
                                                                "Simpan",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
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
                                              ),
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
      ),
      floatingActionButton: Obx(() {
        if (controller.loading.value) {
          return Container();
        } else if (controller.isAddVisible.value) {
          return Container();
        } else if (controller.isUpdateVisible.value) {
          return Container();
        } else {
          return FloatingActionButton(
            onPressed: () {
              controller.selectedGenres.clear();
              controller.selectedImages.value = null;
              controller.isAddVisible(true);
            },
            backgroundColor: Primary,
            child: const Icon(Icons.add_rounded, color: Colors.white),
          );
        }
      }),
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

class CustomButton extends StatefulWidget {
  final Map<String, dynamic> listGenre;

  const CustomButton({
    Key? key,
    required this.listGenre,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  MenuBukuController menuBukuController = Get.find<MenuBukuController>();
  Color _buttonColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    String id = '${widget.listGenre['_id']}';
    _buttonColor = menuBukuController.selectedGenres.contains(id)
        ? Primary
        : Colors.transparent;
    return ElevatedButton(
      onPressed: () {
        if (menuBukuController.selectedGenres.contains(id)) {
          menuBukuController.selectedGenres.remove(id);
        } else {
          menuBukuController.selectedGenres.add(id);
        }
        setState(() {
          _buttonColor =
              _buttonColor == Colors.transparent ? Primary : Colors.transparent;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return _buttonColor;
        }),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: Primary, width: 3),
          ),
        ),
      ),
      child: Text(
        '${widget.listGenre['genres_name']}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: _buttonColor == Colors.transparent ? Primary : Colors.white,
        ),
      ),
    );
  }
}
