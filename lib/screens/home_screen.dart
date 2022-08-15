import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_group/modules/my_custom_themes.dart';
import 'package:tutor_group/screens/chat_screen.dart';
import 'package:tutor_group/screens/explore_screen.dart';
import 'package:tutor_group/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();

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
                // physics: const NeverScrollableScrollPhysics(),
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
        backgroundColor: isDark ? utils.botomNavBarD : Colors.white70,
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
