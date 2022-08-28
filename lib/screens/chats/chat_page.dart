import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/chats/chat_field.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.friendUser}) : super(key: key);
  final UserModelReady friendUser;

  @override
  Widget build(BuildContext context) {
    final String? userImage;
// this is the format of getting image by url
    if (friendUser.imageUrl != null || friendUser.imageUrl!.isNotEmpty) {
      final String image = friendUser.imageUrl!.replaceAll("/", "%2F");
      userImage =
          'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
    } else {
      userImage = null;
    }

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Row(
            children: [
              if (friendUser.imageUrl!.isEmpty ||
                  friendUser.imageUrl == null ||
                  userImage == null)
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/tutorlogo.png'),
                )
              else
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(userImage),
                ),
              const SizedBox(width: 15),
              Text(
                friendUser.gender == 'Male'
                    ? "Mr  ${friendUser.name}"
                    : " Mrs  ${friendUser.name}",
              ),
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
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      child: Column(
                        children: const [
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                          BubbleSpecialThree(
                            text: 'Please try and give some feedback  it!',
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          BubbleSpecialThree(
                            text: 'Sure',
                            color: Color(0xFFE8E8EE),
                            tail: false,
                            isSender: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const ChatField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
