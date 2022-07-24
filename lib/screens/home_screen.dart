import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
