import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/chats/chat_field.dart';
import 'package:tutor_group/screens/chats/stream_fetching_message_user.dart';
import 'package:tutor_group/services/chat_services.dart';

import 'stream_fetching_messages_teacher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.friendUser}) : super(key: key);
  final UserModelReady friendUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final String? userImage;
// this is the format of getting image by url
    if (widget.friendUser.imageUrl != null) {
      if (widget.friendUser.imageUrl!.isNotEmpty) {
        final String image = widget.friendUser.imageUrl!.replaceAll("/", "%2F");
        userImage =
            'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
      } else {
        userImage = null;
      }
    } else {
      userImage = null;
    }

    return GestureDetector(
      onTap: (() => FocusScope.of(context).previousFocus()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Row(
            children: [
              userImage == null
                  ? const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/tutorlogo.png'),
                    )
                  : CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(userImage),
                    ),
              const SizedBox(width: 15),
              Text(widget.friendUser.name),
            ],
          ),
        ),
        body: Scrollbar(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: ChatServices().teacherCheckerTraffic(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: SelectableText(snapshot.error.toString()),
                          );
                        } else if (snapshot.data != null &&
                            snapshot.data!.exists) {
                          // ignore: todo
                          // TODO: this if the user was Teacher
                          return StreamForTeacherFetchingMessages(
                            friendUser: widget.friendUser,
                          );
                        } else if (snapshot.data != null &&
                            !snapshot.data!.exists) {
                          // ignore: todo
                          // TODO: this if the user was User
                          return StreamForUserFetchingMessages(
                              friendUser: widget.friendUser);
                        } else {
                          return const Center(
                            child: Text('Oops! something wentWrong'),
                          );
                        }
                      },
                    ),
                  ),
                ),
                ChatField(freind: widget.friendUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
