import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/setting_page.dart';
import 'package:tutor_group/utils/utils.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils();
    Color color = Theme.of(context).brightness == Brightness.dark
        ? utils.textWhiteD
        : utils.textBlackL;
    final bool isAndroid = Platform.isAndroid;
    return Scaffold(
      // appBar: myProfileAppBar(),

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        (isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
                        color: color,
                        size: 30,
                      ),
                    ),
                    const Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.to(() => const Settings());
                      },
                      icon: Icon(
                        Icons.settings,
                        color: color,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
