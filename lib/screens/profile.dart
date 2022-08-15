import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';
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
    final bool isAndroid = GetPlatform.isAndroid;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: myHomeAppBar(
            title: 'Profile',
            titleColor: isDark ? utils.textWhiteD : utils.textBlackL,
            backgroundColor: isDark ? utils.backgroundD : utils.backgroundL,
            actions: [
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.to(
                    () => const Settings(),
                    transition: Transition.cupertino,
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: color,
                  size: 25,
                ),
              ),
            ]),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: const [
              // Positioned(
              //   top: isAndroid ? 5 : 10,
              //   left: 20,
              //   right: 20,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'Profile',
              //         style:
              //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //       ),
              //       const Spacer(),
              //       IconButton(
              //         highlightColor: Colors.transparent,
              //         splashColor: Colors.transparent,
              //         onPressed: () {
              //           Get.to(
              //             () => const Settings(),
              //             transition: Transition.cupertino,
              //           );
              //         },
              //         icon: Icon(
              //           Icons.settings,
              //           color: color,
              //           size: 25,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
