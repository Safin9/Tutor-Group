import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';
import 'package:tutor_group/utils/constant.dart';

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
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
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
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                if (snapshot.data!.docs.isNotEmpty && snapshot.hasData) {
                  final String friendUserId = snapshot.data!.docs[index].id;
                  final String lastMessage =
                      snapshot.data!.docs[index]["lastMessage"];
                  // final String dateOfLastMessage = snapshot
                  //     .data!.docs[index]["dateOfLastMessage"]
                  //     .toString();
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: firestore
                        .collection("Teachers")
                        .doc(friendUserId)
                        .get(),
                    builder: ((context, docSnapshot) {
                      // if (docSnapshot.connectionState ==
                      //     ConnectionState.waiting) {
                      //   return const Center(
                      //     child: CircularProgressIndicator.adaptive(),
                      //   );
                      // }
                      if (docSnapshot.hasData && docSnapshot.data!.exists) {
                        final UserModelReady friendInfo =
                            UserModelReady.fromSnapShot(docSnapshot.data!);

                        if (friendInfo.imageUrl != null) {
                          final String image =
                              friendInfo.imageUrl!.replaceAll("/", "%2F");
                          userImage =
                              'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
                        } else {
                          userImage = null;
                        }

                        return ListTile(
                          onTap: (() =>
                              Get.to(() => ChatPage(friendUser: friendInfo))),
                          title: Text(friendInfo.name),
                          // leading: SizedBox(
                          //   height: 25,
                          //   width: 25,
                          //   child: ClipRRect(
                          //     child: userImage == null
                          //         ? Image.asset('assets/images/tutorlogo.png')
                          //         : CachedNetworkImage(
                          //             imageUrl: userImage!,
                          //             fit: BoxFit.cover,
                          //           ),
                          //   ),
                          // ),
                          subtitle: Row(
                            children: [
                              Text(lastMessage),
                              const Spacer(),
                              // Text(dateOfLastMessage)
                            ],
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
