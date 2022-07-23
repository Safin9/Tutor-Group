import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/controller/theme_controller.dart';
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
