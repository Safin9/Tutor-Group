// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/main.dart';

class ThemeController extends GetxController {
  bool get isDark => storage.read('isDark') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool val) async {
    await storage.write('isDark', val);
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
  }
}
