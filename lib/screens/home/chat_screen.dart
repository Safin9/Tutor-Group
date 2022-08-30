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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: getDocs(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  debugPrint('the length${snapshot.data!.docs.length}');
                  final senderUid =
                      snapshot.data!.docs[index]['message'][0]['message'];

                  return ListTile(
                    title: Text('Std. $senderUid'),
                    onTap: (() {}),
                  );
                }),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getUsersUid(
  //     {required BuildContext context}) {
  //   UserModelReady currentUser = context.read<UserProvider>().theUser!;
  //   final CollectionReference exploreCollection =
  //       FirebaseFirestore.instance.collection('Messages');
  //   return exploreCollection
  //       .doc(currentUser.uid)
  //       .collection('Texts')
  //       .snapshots();
  //   // return FirebaseFirestore.instance.collection('Messages').snapshots();
  // }
  Stream<QuerySnapshot<Map<String, dynamic>>> getDocs(
      {required BuildContext context}) {
    UserModelReady currentUser = context.read<UserProvider>().theUser!;

    // final CollectionReference chatReference =
    //     FirebaseFirestore.instance.collection('Chat');
    // final CollectionReference messageReference = chatReference
    //     .doc('rLvgJrsx94QO3j023BOomONm6Oh2') //FIXME: it must get all documents.
    //     .collection('Messages');

    return FirebaseFirestore.instance
        .collection('Messages')
        .doc(currentUser.uid)
        .collection('Texts')
        .snapshots();
  }
}
