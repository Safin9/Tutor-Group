import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/screens/teacher%20Card/teacher_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAndroid = GetPlatform.isAndroid;
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
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Teachers')
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
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else {
                    // return PageView.builder(
                    //     scrollDirection: Axis.vertical,
                    //     itemCount: snapshot.data!.docs.length,
                    //     itemBuilder: ((context, index) {
                    //       final theUser = snapshot.data!.docs[index];
                    //       final user = UserModelReady.fromSnapShot(theUser);
                    //       return TeacherCard(user: user);
                    //     }));
                    return Scrollbar(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          final theUser = snapshot.data!.docs[index];
                          final user = UserModelReady.fromSnapShot(theUser);
                          return TeacherCard(user: user);
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
