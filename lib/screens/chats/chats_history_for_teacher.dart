import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';
import 'package:tutor_group/screens/chats/listtile_shimmer.dart';
import 'package:tutor_group/utils/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_group/widgets/loading_for_firstpage.dart';

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
            .orderBy("dateOfLastMessage", descending: true)
            .snapshots(),
        builder: ((context, snapshotFromStream) {
          if (snapshotFromStream.connectionState == ConnectionState.waiting) {
            return const LoadingForFirstPage();
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
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  endIndent: 15,
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: snapshotFromStream.data!.docs.length,
              itemBuilder: ((context, indexforstream) {
                if (snapshotFromStream.data!.docs.isNotEmpty &&
                    snapshotFromStream.hasData) {
                  final String friendUserId =
                      snapshotFromStream.data!.docs[indexforstream].id;
                  final String lastMessage = snapshotFromStream
                      .data!.docs[indexforstream]["lastMessage"];

                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future:
                        firestore.collection("Users").doc(friendUserId).get(),
                    builder: ((context, docSnapshot) {
                      if (docSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox(
                            height: 50, width: 50, child: ListTileShimmer());
                      }
                      if (docSnapshot.hasData &&
                          docSnapshot.data!.data() != null &&
                          docSnapshot.data!.exists &&
                          snapshotFromStream.data!.docs[indexforstream]
                                  ["dateOfLastMessage"] !=
                              null) {
                        final UserModelReady friendInfo =
                            UserModelReady.fromSnapShot(docSnapshot.data!);
                        final Timestamp lastmessageDate = snapshotFromStream
                            .data!.docs[indexforstream]["dateOfLastMessage"];
                        final DateTime now = DateTime.now();
                        final Duration loadedTime =
                            now.difference(lastmessageDate.toDate());
                        timeago.setLocaleMessages('ar', timeago.ArMessages());
                        final time = timeago.format(now.subtract(loadedTime),
                            locale: 'Ar');
                        return Entry.opacity(
                          duration: const Duration(seconds: 1),
                          child: ListTile(
                            onTap: (() =>
                                Get.to(() => ChatPage(friendUser: friendInfo))),
                            title: Text(friendInfo.name),
                            leading: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: friendInfo.gender == 'Male'
                                  ? Image.asset('assets/images/malestd.png')
                                  : Image.asset("assets/images/femalestd.png"),
                            ),
                            subtitle: Row(
                              children: [
                                lastMessage.trim().length > 20
                                    ? Text(
                                        "${lastMessage.trim().substring(0, 20)}....")
                                    : Text(lastMessage.trim()),
                              ],
                            ),
                            trailing: Text(time),
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
