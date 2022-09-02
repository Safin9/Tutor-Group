import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';
import 'package:tutor_group/screens/home/chat_screen.dart';

class ChatServices {
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future sendAMessage({
    // required ChatModel chatModel,
    required BuildContext context,
    required UserModelReady friendUser,
  }) async {
    final UserModelReady currentUser =
        Provider.of<UserProvider>(context, listen: false).theUser!;
// TODO: check if document exist > docId : generate a doc and save it id on doc with myUid and friendUid;
// TODO: create collection messages contains a doc with same above DocId and store in that  doc a collection "Texts" each doc in it contains {
// "senderUid ":
// "recieverUid":
// "message ": haha
// "FieldValue.timeStamp()":
// }
    Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionChatSnapshots() {
      return firestore
          .collection('Chat')
          .where('myUid', isEqualTo: firebaseAuth.currentUser!.uid)
          .snapshots();
    }

    CollectionReference chatDocs = firestore.collection('Chat');
    String chatId;
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getCollectionChatSnapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          chatDocs.where("friendUid", isEqualTo: friendUser.uid).get().then(
            (value) {
              if (value.docs.isNotEmpty) {
                chatId = value.docs.single.id;
              } else {
                chat.add({
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
    );
  }
  // Future sendAMessage({
  //   required ChatModel chatModel,
  //   required BuildContext context,
  //   required UserModelReady friendUser,
  // }) async {
  //   final UserModelReady currentUser =
  //       Provider.of<UserProvider>(context, listen: false).theUser!;

  //   final MessageModel message = MessageModel(
  //       message:
  //           'chdkay neeeeeeewwwwwwwwwwwwww hhh ${currentUser.name}to  ${friendUser.name}',
  //       theSendersName: currentUser.name,
  //       theSenderUid: currentUser.uid);
  //   final ChatModel chat = ChatModel(
  //       myUid: currentUser.uid,
  //       myName: currentUser.name,
  //       friendUid: friendUser.uid,
  //       friendName: friendUser.name,
  //       message: [message]);
  //   await firestore
  //       .collection('Messages/${friendUser.uid}/Texts')
  //       // .doc(friendUser.uid)
  //       // .set(chat.toMap())
  //       .add(chat.toMap())
  //       .then((value) => print('send sucesssssssssssssssfullyyyyyy'));
  // }
}
