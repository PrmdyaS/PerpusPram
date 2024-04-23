import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/management_user_controller.dart';

class ManagementUserView extends GetView<ManagementUserController> {
  const ManagementUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Management User',
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
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: ListView.builder(
                    itemCount: controller.usersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${index + 1}.",
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "${controller.usersList[index].username}",
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  "${controller.usersList[index].email}",
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
                                leading: Obx(() =>
                                    "${controller.usersList[index].profilePicture}" ==
                                            ""
                                        ? const Icon(Icons.account_circle,
                                            size: 47)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              "${controller.usersList[index].profilePicture}",
                                            ),
                                          )),
                              ),
                            ),
                            dropDownWidget(
                                role:
                                    "${controller.usersList[index].indexLevelRoles}",
                                id: "${controller.usersList[index].id}"),
                          ],
                        ),
                      );
                    },
                  ),
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
              } else if (controller.selectAlert.value == 'danger') {
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
                        'Tutup',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
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
        ],
      ),
      floatingActionButton: Obx(() => AnimatedOpacity(
            opacity: controller.updateList.value.isEmpty ? 0.0 : 1.0,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Container(
              margin: EdgeInsets.only(right: 5, bottom: 7),
              child: ElevatedButton(
                onPressed: () {
                  controller.updateRoles();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ).copyWith(
                  backgroundColor: MaterialStateProperty.all(Primary),
                ),
                child: Obx(() => controller.loadingUpdate.value
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Simpan",
                            style: GoogleFonts.getFont(
                              'Poppins',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          const Icon(Icons.save, color: Colors.white, size: 18),
                        ],
                      )),
              ),
            ),
          )),
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

class dropDownWidget extends StatefulWidget {
  final String role;
  final String id;

  const dropDownWidget({Key? key, required this.role, required this.id})
      : super(key: key);

  @override
  State<dropDownWidget> createState() => _dropDownWidgetState();
}

class _dropDownWidgetState extends State<dropDownWidget> {
  final controller = Get.find<ManagementUserController>();

  @override
  Widget build(BuildContext context) {
    var selectedItem = widget.role.obs;
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 100,
      height: 40,
      child: Obx(() => controller.loadingRoles.value
          ? Container()
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(() => DropdownButton<String>(
                      value: selectedItem.value.isEmpty
                          ? null
                          : selectedItem.value,
                      icon: Icon(Icons.expand_more_rounded,
                          color: Theme.of(context).colorScheme.primary),
                      hint: Text(
                        'Role',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      iconSize: 20,
                      onChanged: (String? newValue) {
                        selectedItem.value = newValue!;
                        var listUpdated = false;
                        for (var i = 0; i < controller.updateList.length; i++) {
                          var updateLists = controller.updateList[i];
                          if (updateLists['_id'] == widget.id) {
                            updateLists['index_level_roles'] = newValue;
                            listUpdated = true;
                            break;
                          }
                        }
                        if (!listUpdated) {
                          var listUpdate = {
                            '_id': widget.id,
                            'index_level_roles': newValue
                          };
                          controller.updateList.add(listUpdate);
                        }
                      },
                      items: controller.rolesList.map((roles) {
                        return DropdownMenuItem<String>(
                          value: roles["index_level"],
                          child: Text(
                            roles["role_name"],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      dropdownColor: Theme.of(context).colorScheme.background,
                      underline: Container(),
                      elevation: 0,
                      isExpanded: true,
                      itemHeight: 50,
                    )),
              ),
            )),
    );
  }
}
