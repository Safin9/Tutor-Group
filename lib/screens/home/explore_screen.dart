import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/screens/chats/teacher_profile_details.dart';
import 'package:tutor_group/widgets/teacher_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    // String currentLoc = context.read<UserProvider>().theUser!.currentCity;
    String? filterCity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value != null) {
                  filterCity = value.toString();
                } else {
                  filterCity = null;
                }

                print(filterCity);
              });
            },
            itemBuilder: ((context) => [
                  const PopupMenuItem(
                    value: null,
                    child: Text('All'),
                  ),
                  const PopupMenuItem(
                    value: 'Duhok',
                    child: Text('Duhok'),
                  ),
                  const PopupMenuItem(
                    value: 'Erbil',
                    child: Text('Erbil'),
                  ),
                  const PopupMenuItem(
                    value: 'Slemmany',
                    child: Text('Slemmany'),
                  ),
                  const PopupMenuItem(
                    value: 'Karkuk',
                    child: Text('Karkuk'),
                  ),
                  const PopupMenuItem(
                    value: 'Zakho',
                    child: Text('Zakho'),
                  ),
                  const PopupMenuItem(
                    value: 'Halabja',
                    child: Text('Halabja'),
                  ),
                ]),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: ToolsForLogAndSignup().myBackgroundImage(
                    isDark ? Colors.grey.withOpacity(0.5) : Colors.grey),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Teachers')
                    .where("currentCity", isEqualTo: filterCity)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SelectableText(snapshot.error.toString()),
                    );
                  } else if (snapshot.data == null || snapshot.data == '') {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else {
                    return Scrollbar(
                      child: ListView.builder(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          final theUser = snapshot.data!.docs[index];
                          final friendUser =
                              UserModelReady.fromSnapShot(theUser);
                          return GestureDetector(
                              onTap: (() => Get.to(() => TeacherProfileDetails(
                                  friendUser: friendUser))),
                              child: TeacherCard(user: friendUser));
                        }),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
