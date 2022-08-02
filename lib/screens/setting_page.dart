import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/utils/utils.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    final utils = Utils();
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                padding: const EdgeInsets.all(8.0),
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
                      title: 'About us',
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
