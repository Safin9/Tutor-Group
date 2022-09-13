import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';
import 'package:tutor_group/utils/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tutor_group/widgets/loading_for_firstpage.dart';

import 'listtile_shimmer.dart';

class ChatHistoryForUsers extends StatelessWidget {
  const ChatHistoryForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? userImage;
    final UserModelReady currentUser = context.read<UserProvider>().theUser!;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection("Users")
            .doc(currentUser.uid)
            .collection("Messages")
            .orderBy("dateOfLastMessage", descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingForFirstPage();
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No chats yet"),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: SelectableText(
              snapshot.error.toString(),
            ));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 15,
                  endIndent: 35,
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                if (snapshot.data!.docs.isNotEmpty && snapshot.hasData) {
                  final String friendUserId = snapshot.data!.docs[index].id;
                  final String lastMessage =
                      snapshot.data!.docs[index]["lastMessage"];

                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: firestore
                        .collection("Teachers")
                        .doc(friendUserId)
                        .get(),
                    builder: ((context, docSnapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                            height: 50, width: 50, child: ListTileShimmer());
                      }
                      if (docSnapshot.hasData &&
                          docSnapshot.data!.exists &&
                          snapshot.data!.docs[index]["dateOfLastMessage"] !=
                              null) {
                        final UserModelReady friendInfo =
                            UserModelReady.fromSnapShot(docSnapshot.data!);
                        final Timestamp lastmessageDate =
                            snapshot.data!.docs[index]["dateOfLastMessage"];
                        if (friendInfo.imageUrl != null) {
                          if (friendInfo.imageUrl!.isNotEmpty) {
                            final String image =
                                friendInfo.imageUrl!.replaceAll("/", "%2F");
                            userImage =
                                'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
                          } else {
                            userImage = null;
                          }
                        } else {
                          userImage = null;
                        }

                        final DateTime now = DateTime.now();
                        final Duration loadedTime =
                            now.difference(lastmessageDate.toDate());
                        timeago.setLocaleMessages('ar', timeago.ArMessages());
                        final time = timeago.format(now.subtract(loadedTime),
                            locale: 'Ar');
                        return Entry.opacity(
                          duration: const Duration(milliseconds: 750),
                          child: ListTile(
                            onTap: (() =>
                                Get.to(() => ChatPage(friendUser: friendInfo))),
                            title: Text(friendInfo.name),
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: userImage == null
                                    ? Image.asset('assets/images/tutorlogo.png')
                                    : CachedNetworkImage(
                                        imageUrl: userImage!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            trailing: Text(time),
                            subtitle: Row(
                              children: [
                                lastMessage.trim().length > 20
                                    ? Text(
                                        "${lastMessage.trim().substring(0, 20)}....")
                                    : Text(lastMessage.trim()),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    }),
                  );
                } else {
                  return const Center(
                    child: Text('something went wrong'),
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
