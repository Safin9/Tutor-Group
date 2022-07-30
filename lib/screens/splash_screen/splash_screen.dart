import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/home_screen.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  Future<Widget> loadFromFuture() async {
    // <fetch data from server. ex. login>

    return Future.value(const HomeScreen());
  }

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  var dur = const Duration(seconds: 3);
  void starttimer() async {
    await Future.delayed(dur);
    route();
  }

  void route() {
    Get.offAll(
      () => const HomeScreen(),
      curve: Curves.slowMiddle,
      duration: const Duration(milliseconds: 1500),
      transition: Transition.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(20, 12, 52, 1),
      child: Center(
        child: Image.asset('assets/images/tutorlogo.png'),
      ),
    );
  }
}
