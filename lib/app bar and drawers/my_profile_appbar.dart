import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/setting_page.dart';

PreferredSizeWidget myProfileAppBar() {
  return AppBar(
    title: const Text('profile'),
    actions: [
      IconButton(
          onPressed: () {
            Get.to(() => const Settings());
          },
          icon: const Icon(Icons.settings))
    ],
  );
}
