import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/utils/utils.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserModelReady currentUser = context.read<UserProvider>().theUser!;
    bool isDark = Get.isDarkMode;
    return Scaffold(
      appBar: myHomeAppBar(
        titleColor: isDark ? textWhiteD : textBlackL,
        title: 'Chats',
        backgroundColor: isDark ? backgroundD : backgroundL,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          color: Colors.amber,
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersUid() {
    return FirebaseFirestore.instance.collection('Users').snapshots();
  }
}
