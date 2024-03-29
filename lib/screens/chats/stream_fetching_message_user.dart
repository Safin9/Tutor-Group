import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/message_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/services/chat_services.dart';

class StreamForUserFetchingMessages extends StatefulWidget {
  const StreamForUserFetchingMessages({Key? key, required this.friendUser})
      : super(key: key);
  final UserModelReady friendUser;

  @override
  State<StreamForUserFetchingMessages> createState() =>
      _StreamForUserFetchingMessagesState();
}

class _StreamForUserFetchingMessagesState
    extends State<StreamForUserFetchingMessages> {
  @override
  Widget build(BuildContext context) {
    final UserModelReady currentUser = context.read<UserProvider>().theUser!;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ChatServices()
              .gettingChatsForUser(context, currentUser, widget.friendUser),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: SelectableText(
                snapshot.error.toString(),
              ));
            } else if (snapshot.data == null) {
              return const Center(
                child: Text('No data to show!'),
              );
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Say Hi!'),
                );
              } else if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    if (snapshot.data!.docs[index]["sentAt"] != null) {
                      MessageModel msg =
                          MessageModel.fromSnapShot(snapshot.data!, index);
                      if (msg.senderUid == currentUser.uid) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BubbleSpecialThree(
                                isSender: true,
                                text: msg.message,
                              ),
                              Text(
                                msg.sentAt.toDate().toString().substring(0, 16),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BubbleSpecialThree(
                                isSender: false,
                                color: Colors.blue,
                                text: msg.message,
                              ),
                              Text(
                                msg.sentAt.toDate().toString().substring(0, 16),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }

                    return const Text('');
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
