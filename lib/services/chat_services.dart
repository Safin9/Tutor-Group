import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/chat_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';

import '../modules/message_model.dart';

class ChatServices {
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future sendAMessage({
    required ChatModel chatModel,
    required BuildContext context,
    required UserModelReady friendUser,
  }) async {
    final UserModelReady currentUser =
        Provider.of<UserProvider>(context, listen: false).theUser!;

    final MessageModel message = MessageModel(
        message:
            'Hello I am ffffffff ${currentUser.name}to  ${friendUser.name}',
        theSendersName: currentUser.name,
        theSenderUid: currentUser.uid);
    final ChatModel chat = ChatModel(
        myUid: currentUser.uid,
        myName: currentUser.name,
        friendUid: friendUser.uid,
        friendName: friendUser.name,
        message: [message]);
    await firestore
        .collection('Chats/${currentUser.uid}/Messages/${friendUser.uid}/Texts')
        // .doc(friendUser.uid)
        // .set(chat.toMap())
        .add(chat.toMap())
        .then((value) => print('send sucesssssssssssssssfullyyyyyy'));
  }
}
