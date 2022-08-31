import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/chat_model.dart';
import 'package:tutor_group/modules/message_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/services/chat_services.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key, required this.freind}) : super(key: key);
  final UserModelReady freind;
  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  late FocusNode myFocusNode;
  TextEditingController? messageCOntroller;

  @override
  void initState() {
    super.initState();
    messageCOntroller = TextEditingController();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    messageCOntroller!.dispose();
    super.dispose();
  }

  ChatServices chatServices = ChatServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserProvider>().theUser;
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 158, 156, 156).withOpacity(0.2),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) async {
                        if (value.isNotEmpty && value.trim() != '') {
                          // TODO: send the message here
                          print(
                              'successsssssssssm     ${messageCOntroller!.text.trim()}');
                          myFocusNode.requestFocus();
                          messageCOntroller!.clear();
                        }
                        messageCOntroller!.clear();
                        final message = MessageModel(
                            theSendersName: currentUser!.name,
                            theSenderUid: currentUser.uid,
                            message: 'message');
                        final chatmodel = ChatModel(
                            myUid: currentUser.uid,
                            myName: currentUser.name,
                            friendUid: widget.freind.uid,
                            message: [message],
                            friendName: widget.freind.name);
                        // await chatServices.sendAMessage(
                        //     chatModel: chatmodel,
                        //     context: context,
                        //     friendUser: widget.freind);
                      },
                      controller: messageCOntroller,
                      maxLines: 5,
                      minLines: 1,
                      autofocus: true,
                      focusNode: myFocusNode,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.send,
                      keyboardAppearance:
                          Get.isDarkMode ? Brightness.dark : Brightness.light,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintStyle: TextStyle(color: Color(0xFF1B97F3)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // GestureDetector(
                  //   onTap: (() async {
                  //     final message = MessageModel(
                  //         theSendersName: currentUser!.name,
                  //         theSenderUid: currentUser.uid,
                  //         message: 'message');
                  //     final chatmodel = ChatModel(
                  //         myUid: currentUser.uid,
                  //         myName: currentUser.name,
                  //         friendUid: widget.freind.uid,
                  //         message: [message],
                  //         friendName: widget.freind.name);
                  //     chatServices.sendAMessage(
                  //         chatModel: chatmodel,
                  //         context: context,
                  //         friendUser: widget.freind);
                  //   }),
                  //   child: Container(
                  //     padding: const EdgeInsets.all(15.0),
                  //     decoration: const BoxDecoration(
                  //         color: Color(0xFF1B97F3), shape: BoxShape.circle),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
