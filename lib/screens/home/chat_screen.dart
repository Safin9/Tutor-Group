import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

CollectionReference chat = FirebaseFirestore.instance.collection('Chats');
String? chatId;

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    chat
        .where('myUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        chatId = chat.doc().id;
      } else {
        chat.add({
          //FIXME: add message model here
        }).then((querySnapshot) {
          chatId = querySnapshot.id;
        });
      }
    }).catchError((err) {});
    super.initState();
  }

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
                    // leading: SendMessageButton(friendUser: friendUser),
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

  // FIXME: rebuild the logic
  Stream<QuerySnapshot<Map<String, dynamic>>> getDocs(
      {required BuildContext context}) {
    UserModelReady currentUser = context.read<UserProvider>().theUser!;
    return FirebaseFirestore.instance
        .collection('Messages')
        .doc(currentUser.uid)
        .collection('Texts')
        .snapshots();
  }
}
