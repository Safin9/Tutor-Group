import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<DocumentReference> addANameToTheDB({required String name}) async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection('names').add({
      "first_name": name,
    });
    return doc;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
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
        backgroundColor: isDark ? Colors.black87 : Colors.white70,
        curve: Curves.easeInToLinear,
        items: [
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: isDark ? Colors.white : Colors.black,
              icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
              title: const Text('Home')),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: isDark ? Colors.white : Colors.black,
              icon: Icon(currentIndex == 1 ? Icons.chat_bubble : Icons.chat),
              title: const Text('Chats')),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: isDark ? Colors.white : Colors.black,
              icon: Icon(currentIndex == 2
                  ? Icons.account_circle
                  : Icons.account_circle_outlined),
              title: const Text('Account')),
        ],
        onItemSelected: ((index) {
          setState(
            () {
              currentIndex = index;
              _pageController!.animateToPage(index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.fastOutSlowIn);
            },
          );
        }),
      ),
    );
  }
}
