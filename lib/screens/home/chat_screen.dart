import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tutor_group/screens/chats/chats_history_for_teacher.dart';
import 'package:tutor_group/screens/chats/chats_history_for_users.dart';
import 'package:tutor_group/screens/chats/shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Teachers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshotFromFuture) {
              if (snapshotFromFuture.connectionState ==
                  ConnectionState.waiting) {
                return const ShimmerFirChatHistory();
              } else if (snapshotFromFuture.hasError) {
                return Center(
                  child: Text(snapshotFromFuture.error.toString()),
                );
              } else if (snapshotFromFuture.data!.exists) {
                return const ChatHistoryForTeacher();
              } else if (!snapshotFromFuture.data!.exists) {
                return const ChatHistoryForUsers();
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            }),
      ),
    );
  }
}
