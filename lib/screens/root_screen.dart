import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/modules/my_custom_themes.dart';
import 'package:tutor_group/screens/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    final theme = Get.find<ThemeController>();
    return GetMaterialApp(
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: MyThemes().darkTheme,
        home: const HomeScreen());
  }
}
