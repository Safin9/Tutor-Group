import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
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
            // Positioned.fill(
            //   top: 29,
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: ClipOval(
            //       child: Container(
            //         height: 80,
            //         width: 80,
            //         color: Colors.red,
            //         child: const Center(child: Text('Profile')),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: isDark ? Colors.white : Colors.black,
        currentIndex: currentIndex,
        iconSize: 25,
        backgroundColor: isDark ? utils.botomNavBarD : Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: currentIndex == 0 ? 'Explore' : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: currentIndex == 1 ? 'Chats' : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: currentIndex == 2 ? 'Account' : '',
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
