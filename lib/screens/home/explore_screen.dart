import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/screens/chats/teacher_profile_details.dart';
import 'package:tutor_group/utils/general_dropdown.dart';
import 'package:tutor_group/utils/strings.dart';
import 'package:tutor_group/widgets/teacher_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String filtered(BuildContext context, String? filterCities) {
    if (filterCities == null) {
      return context.read<UserProvider>().theUser!.currentCity;
    }
    return filterCities;
  }

  String filterCity = 'Duhok';
  String filterSubject = 'Kurdish';
  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
              Positioned.fill(
                top: 60,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Teachers')
                      .where('currentCity',
                          isEqualTo: filtered(context, filterCity))
                      .where('lessonType', isEqualTo: filterSubject)
                      .orderBy('createdAt', descending: true)
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
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final theUser = snapshot.data!.docs[index];
                            final friendUser =
                                UserModelReady.fromSnapShot(theUser);

                            return GestureDetector(
                                onTap: (() => Get.to(() =>
                                    TeacherProfileDetails(
                                        friendUser: friendUser))),
                                child: TeacherCard(user: friendUser));
                          }),
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                child: Row(
                  children: [
                    SizedBox(
                      height: 55,
                      width: 180,
                      child: GeneralDropDownButton(
                        itemsList: citysList,
                        selectedItem: filtered(context, filterCity),
                        valueChanged: (value) {
                          setState(() {
                            // filtered(context, value);
                            filterCity = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: 200,
                      child: GeneralDropDownButton(
                        itemsList: lessonType,
                        selectedItem: lessonType.first,
                        valueChanged: (value) {
                          setState(() {
                            // filtered(context, value);
                            filterSubject = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
