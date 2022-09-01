import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/chats/chat_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.friendUser}) : super(key: key);
  final UserModelReady friendUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference chat = FirebaseFirestore.instance.collection('Chats');
  String? chatId;

  @override
  void initState() {
    chat
        .where('myUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          chatId = querySnapshot.docs.single.id;
        });
      } else {
        chat.add({
          //FIXME: add message model here
          'myUid': FirebaseAuth.instance.currentUser!.uid,
          'friendUid': widget.friendUser.uid,
          'myName': widget.friendUser.uid,
          'docId': chatId,
        }).then((doc) {
          setState(() {
            chatId = doc.id;
          });
        });
      }
    }).catchError((err) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String? userImage;
// this is the format of getting image by url
    if (widget.friendUser.imageUrl != null ||
        widget.friendUser.imageUrl!.isNotEmpty) {
      final String image = widget.friendUser.imageUrl!.replaceAll("/", "%2F");
      userImage =
          'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
    } else {
      userImage = null;
    }
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Row(
            children: [
              if (widget.friendUser.imageUrl!.isEmpty ||
                  widget.friendUser.imageUrl == null ||
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
                widget.friendUser.gender == 'Male'
                    ? "Mr  ${widget.friendUser.name}"
                    : " Mrs  ${widget.friendUser.name}",
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
                      physics: const BouncingScrollPhysics(),
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
                            text: 'Please try and give some feedback  it!',
                            color: Color.fromARGB(255, 235, 239, 241),
                            tail: true,
                            isSender: false,
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
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
