import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    required String collectionType,
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
    // MessageModel messageDetails = MessageModel(
    //   message: message,
    //   senderUid: currentUser.uid,
    //   senderName: currentUser.name,
    //   recieverUid: friend.uid,
    //   recieverName: friend.name,
    //   messageType: "text",
    //   sentAt: FieldValue.serverTimestamp(),
    // );
    await firestore
        .collection(collectionType)
        .doc(currentUser.uid)
        .collection("Messages")
        .doc(friend.uid)
        .collection("Chats")
        .add({
      "message": message,
      "senderUid": currentUser.uid,
      "senderName": currentUser.name,
      "recieverUid": friend.uid,
      "recieverName": friend.name,
      "messageType": "text",
      "sentAt": FieldValue.serverTimestamp()
    }).then(
      (_) {
        firestore
            .collection(collectionType)
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
        .collection(collectionType == "Users" ? "Teachers" : "Users")
        .doc(friend.uid)
        .collection("Messages")
        .doc(currentUser.uid)
        .collection("Chats")
        .add({
      "message": message,
      "senderUid": currentUser.uid,
      "senderName": currentUser.name,
      "recieverUid": friend.uid,
      "recieverName": friend.name,
      "messageType": "text",
      "sentAt": FieldValue.serverTimestamp()
    }).then((_) {
      firestore
          .collection(collectionType == "Users" ? "Teachers" : "Users")
          .doc(friend.uid)
          .collection("Messages")
          .doc(currentUser.uid)
          .set(({
            "lastMessage": message,
            "dateOfLastMessage": FieldValue.serverTimestamp(),
          }));
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> teacherCheckerTraffic(
      BuildContext context) {
    final UserModelReady currentUser = context.read<UserProvider>().theUser!;

    return firestore.collection("Teachers").doc(currentUser.uid).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> gettingChatsForUser(
    BuildContext context,
    UserModelReady currentUser,
    UserModelReady friendUser,
  ) {
    return firestore
        .collection("Users")
        .doc(currentUser.uid)
        .collection("Messages")
        .doc(friendUser.uid)
        .collection("Chats")
        .orderBy("sentAt", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> gettingChatsForTeacher(
    BuildContext context,
    UserModelReady currentUser,
    UserModelReady friendUser,
  ) {
    return firestore
        .collection("Teachers")
        .doc(currentUser.uid)
        .collection("Messages")
        .doc(friendUser.uid)
        .collection("Chats")
        .orderBy("sentAt", descending: true)
        .snapshots();
  }
}
