import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/services/auth_services.dart';
import 'package:tutor_group/utils/utils.dart';
import 'dart:io';

class Settingsr extends StatefulWidget {
  const Settingsr({Key? key}) : super(key: key);

  @override
  State<Settingsr> createState() => _SettingsrState();
}

class _SettingsrState extends State<Settingsr> {
  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    final utils = Utils();
    AuthServices authServices = AuthServices();
    Color tileColor = Theme.of(context).brightness == Brightness.dark
        ? utils.textGreyL
        : utils.textGreyD;
    final bool isAndroid = Platform.isAndroid;
    Color color = Theme.of(context).brightness == Brightness.dark
        ? utils.textWhiteD
        : utils.textBlackL;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10,
                child: Row(
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        (isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
                        color: color,
                        size: 20,
                      ),
                    ),
                    const Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 0.1 * size.height,
                  left: 0.02 * size.width,
                  right: 0.02 * size.width,
                ),
                child: Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Platform.isAndroid
                              ? SwitchListTile(
                                  tileColor: tileColor,
                                  value: theme.isDark,
                                  onChanged: (value) {
                                    setState(() {
                                      theme.changeTheme(value);
                                    });
                                  },
                                  title: const Text('Dark Mode'),
                                )
                              : Container(
                                  color: tileColor,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Row(
                                      children: [
                                        const Text('Dark Mode'),
                                        const Spacer(),
                                        CupertinoSwitch(
                                            value: theme.isDark,
                                            onChanged: (value) {
                                              setState(() {
                                                theme.changeTheme(value);
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        myListTile(
                          tileColor: tileColor,
                          title: 'Log out',
                          onTap: () async {
                            // await authServices.logout();
                            await FirebaseAuth.instance.signOut();
                          },
                        ),
                        myListTile(
                          tileColor: tileColor,
                          title: 'About us',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding myListTile({
    required Color tileColor,
    required String title,
    GestureTapCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        tileColor: tileColor,
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
