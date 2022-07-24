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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          myListTile(
            tileColor: tileColor,
            title: 'About us',
          ),
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
        ],
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
