import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';
import 'package:tutor_group/modules/my_custom_themes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.isDarkMode;
    return Scaffold(
      appBar: myHomeAppBar(
        titleColor: isDark ? utils.textWhiteD : utils.textBlackL,
        title: 'Chats',
        backgroundColor: isDark ? utils.backgroundD : utils.backgroundL,
      ),
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
