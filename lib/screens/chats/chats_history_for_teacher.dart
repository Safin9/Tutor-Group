import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';
import 'package:tutor_group/utils/constant.dart';

class ChatHistoryForTeacher extends StatelessWidget {
  const ChatHistoryForTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModelReady currentUser = context.read<UserProvider>().theUser!;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection("Teachers")
            .doc(currentUser.uid)
            .collection("Messages")
            .snapshots(),
        builder: ((context, snapshotFromStream) {
          if (snapshotFromStream.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshotFromStream.data!.docs.isEmpty) {
            return const Center(
              child: Text("No chats yet"),
            );
          } else if (snapshotFromStream.hasError) {
            return Center(
                child: SelectableText(
              snapshotFromStream.error.toString(),
            ));
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshotFromStream.data!.docs.length,
              itemBuilder: ((context, indexforstream) {
                if (snapshotFromStream.data!.docs.isNotEmpty &&
                    snapshotFromStream.hasData) {
                  final String friendUserId =
                      snapshotFromStream.data!.docs[indexforstream].id;
                  final String lastMessage = snapshotFromStream
                      .data!.docs[indexforstream]["lastMessage"];
                  // final String dateOfLastMessage =
                  //     snapshot.data!.docs[index]["dateOfLastMessage"];
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future:
                        firestore.collection("Users").doc(friendUserId).get(),
                    builder: ((context, docSnapshot) {
                      if (docSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (docSnapshot.hasData &&
                          docSnapshot.data!.data() != null &&
                          docSnapshot.data!.exists) {
                        final UserModelReady friendInfo =
                            UserModelReady.fromSnapShot(docSnapshot.data!);
                        return ListTile(
                          onTap: (() =>
                              Get.to(() => ChatPage(friendUser: friendInfo))),
                          title: Text(friendInfo.name),
                          leading: ClipRRect(
                              child:
                                  Image.asset('assets/images/tutorlogo.png')),
                          subtitle: Row(
                            children: [
                              Text(lastMessage),
                              const Spacer(),
                            ],
                          ),
                        );
                      } else {
                        return const Nil();
                      }
                    }),
                  );
                } else {
                  return const Center(
                    child: Text('Ops something went wrong'),
                  );
                }
              }),
            );
          }
        }),
      ),
    );
  }
}
