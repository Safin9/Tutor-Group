import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/utils/utils.dart';

class Settingsr extends StatefulWidget {
  const Settingsr({Key? key}) : super(key: key);

  @override
  State<Settingsr> createState() => _SettingsrState();
}

class _SettingsrState extends State<Settingsr> {
  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    Color tileColor =
        Theme.of(context).brightness == Brightness.dark ? textGreyL : textGreyD;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        height: double.infinity,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: SwitchListTile.adaptive(
                    tileColor: tileColor,
                    value: theme.isDark,
                    onChanged: (value) {
                      setState(() {
                        theme.changeTheme(value);
                      });
                    },
                    title: const Text('Dark Mode'),
                  )),
              myListTile(
                tileColor: tileColor,
                title: 'Log out',
                onTap: logout,
              ),
              myListTile(
                tileColor: tileColor,
                title: 'About us',
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout() {
    showDialog(
        context: context,
        builder: ((context) {
          return GetPlatform.isAndroid
              ? AlertDialog(
                  title: const Text('Log Out'),
                  content: Wrap(
                    children: const [Text('Are you sure?')],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        child: const Text('Confirm')),
                  ],
                )
              : CupertinoAlertDialog(
                  title: const Text('Log Out'),
                  actions: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        child: const Text('Confirm')),
                  ],
                );
        }));
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
