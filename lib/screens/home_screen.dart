import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
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
    // TODO: implement initState
    _pageController = PageController();
    print('initialized');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController!.dispose();
    print('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => setState(() {
                  currentIndex = value;
                }),
                children: const [
                  ExploreScreen(),
                  ChatScreen(),
                  Profile(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          curve: Curves.easeIn,
          items: [
            BottomNavyBarItem(
                activeColor: isDark ? Colors.white : Colors.black,
                icon: const Icon(Icons.home),
                title: const Text('Home')),
            BottomNavyBarItem(
                activeColor: isDark ? Colors.white : Colors.black,
                icon: const Icon(Icons.chat),
                title: const Text('Chats')),
            BottomNavyBarItem(
                activeColor: isDark ? Colors.white : Colors.black,
                icon: const Icon(Icons.account_circle),
                title: const Text('Account')),
          ],
          onItemSelected: ((index) {
            setState(() {
              currentIndex = index;
              _pageController!.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            });
          }),
        ));
  }
}
