import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
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
  String? filterCity;
  String? filterSubject;
  @override
  Widget build(BuildContext context) {
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
                child: ToolsForLogAndSignup()
                    .myBackgroundImage(Colors.grey.withOpacity(0.2)),
              ),
              Positioned.fill(
                top: 60,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Teachers')
                      .where('currentCity',
                          isEqualTo: filterCity != 'All' ? filterCity : null)
                      .where('lessonType',
                          isEqualTo:
                              filterSubject != 'All' ? filterSubject : null)
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
                      if (snapshot.data!.docs.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sorry!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'City:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    filterCity ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Subject:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    filterSubject ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'No Teacher is available for filtered specifications yet ..',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      }

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
                                child: Entry.scale(
                                    curve: Curves.easeOutExpo,
                                    duration: const Duration(seconds: 1),
                                    child: TeacherCard(user: friendUser)));
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
                        itemsList: citysListForFilter,
                        selectedItem: filterCity,
                        valueChanged: (value) async {
                          setState(() {
                            filterCity = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: 200,
                      child: GeneralDropDownButton(
                        itemsList: lessonTypeForFilter,
                        selectedItem: filterSubject,
                        valueChanged: (value) async {
                          setState(() {
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
