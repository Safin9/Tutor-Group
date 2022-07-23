import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
import 'package:tutor_group/screens/profile.dart';
import 'package:tutor_group/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils();
    final theme = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => const Profile());
              },
              child: const Text('profile')),
          const Center(
            child: Text('Home Screen'),
          ),
          const Divider(
            thickness: 4,
          ),
          Container(
            color: utils.isDark ? utils.orangeD : utils.blueD,
            height: 100,
            width: 100,
            child: Text(
              'this is my color: ',
              style: TextStyle(
                  color: utils.isDark ? utils.textWhiteD : utils.textBlackL,
                  fontSize: 25),
            ),
          ),
          Switch(
            value: theme.isDark,
            onChanged: ((value) async {
              setState(() {
                theme.changeTheme(value);
              });
            }),
          )
        ],
      ),
    );
  }
}
