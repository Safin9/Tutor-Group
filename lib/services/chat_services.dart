import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/message_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/utils/constant.dart';

class ChatServices {
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionChatSnapshots() {
    return firestore
        .collection('Chat')
        .where('myUid', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> sendAMessage({
    required String message,
    required BuildContext context,
    required UserModelReady friend,
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
    MessageModel messageDetails = MessageModel(
      message: message,
      senderUid: currentUser.uid,
      senderName: currentUser.name,
      recieverUid: friend.uid,
      recieverName: friend.name,
      messageType: "text",
      sentAt: FieldValue.serverTimestamp(),
    );
    await firestore
        .collection("Users")
        .doc(currentUser.uid)
        .collection("Messages")
        .doc(friend.uid)
        .collection("Chats")
        .add(messageDetails.toMap())
        .then(
      (_) {
        firestore
            .collection("Users")
            .doc(currentUser.uid)
            .collection("Messages")
            .doc(friend.uid)
            .set({
          "lastMessage": message,
          "dateOfLastMessage": FieldValue.serverTimestamp(),
        });
      },
    );
    await firestore
        .collection("Teachers")
        .doc(friend.uid)
        .collection("Messages")
        .doc(currentUser.uid)
        .collection("Chats")
        .add(messageDetails.toMap())
        .then((_) {
      firestore
          .collection("Teachers")
          .doc(friend.uid)
          .collection("Messages")
          .doc(currentUser.uid)
          .set(({
            "lastMessage": message,
            "dateOfLastMessage": FieldValue.serverTimestamp(),
          }));
    });
  }
}
