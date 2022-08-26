import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/screens/auth/signup_for_student.dart';

import 'package:tutor_group/utils/constant.dart';

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
      scrollBehavior: const MaterialScrollBehavior(),
      debugShowCheckedModeBanner: false,
      themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
      // theme: kLightTheme,
      // darkTheme: kDarkTheme,
      theme: lightTheme,
      darkTheme: darkTheme,
//  FIXME: add home as HandlerScreen()
      // home: const HandlerScreen(),
      home: const SignUpForStudent(),
    );
  }
}
