import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';

import 'chat_page.dart';

class Chathandler extends StatelessWidget {
  Chathandler({Key? key, required this.friendUser}) : super(key: key);
  UserModelReady friendUser;
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? chatId;
  @override
  Widget build(BuildContext context) {
    CollectionReference chatDocs = firestore.collection('Chat');

    UserModelReady currentUser = context.read<UserProvider>().theUser!;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getCollectionChatSnapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            chatDocs.where("friendUid", isEqualTo: friendUser.uid).get().then(
              (value) {
                if (value.docs.isNotEmpty) {
                  chatId = value.docs.single.id;
                } else {
                  chatDocs.add({
                    "myUid": currentUser.uid,
                    "friendUid": friendUser.uid,
                  }).then((docReference) {
                    docReference.set({"docId": docReference.id});
                  });
                }
              },
            );
            return ChatPage(friendUser: friendUser);
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(snapshot.error.toString()),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: SelectableText('No Data'),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }),
      ),
    );
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionChatSnapshots() {
  return FirebaseFirestore.instance
      .collection('Chat')
      .where('myUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
