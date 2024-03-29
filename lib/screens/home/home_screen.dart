import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/auth/sign_by_phone.dart';
import 'package:tutor_group/screens/home/chat_screen.dart';
import 'package:tutor_group/screens/home/explore_screen.dart';
import 'package:tutor_group/screens/home/profile.dart';
import 'package:tutor_group/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, int? index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    // to listen signing events
    //  this is how to listen signout events
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        // Get.offAll(() => const HandlerScreen());
        Get.offAll(() => SignInByPhone());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) => setState(
                  () {
                    currentIndex = value;
                  },
                ),
                children: const [
                  ExploreScreen(),
                  ChatScreen(),
                  Profile(),
                ],
              ),
            )),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: isDark ? Colors.white : Colors.black,
        currentIndex: currentIndex,
        iconSize: 25,
        backgroundColor: isDark ? botomNavBarD : Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidMessage,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userTie,
              size: 20,
            ),
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
            _pageController!.jumpToPage(value);
          });
        },
      ),
    );
  }
}
