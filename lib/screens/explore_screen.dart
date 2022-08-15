import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';
import 'package:tutor_group/modules/my_custom_themes.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAndroid = GetPlatform.isAndroid;
    final bool isDark = Get.isDarkMode;
    return Scaffold(
      appBar: myHomeAppBar(
          titleColor: isDark ? utils.textWhiteD : utils.textBlackL,
          title: 'Home',
          backgroundColor: isDark ? utils.backgroundD : utils.backgroundL,
          actions: []),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Container(),
        ),
      ),
    );
  }
}
