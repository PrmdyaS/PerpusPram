import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
