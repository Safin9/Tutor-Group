import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';

import 'package:tutor_group/services/chat_services.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key, required this.freind}) : super(key: key);
  final UserModelReady freind;
  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController? messageCOntroller;

  @override
  void initState() {
    super.initState();
    messageCOntroller = TextEditingController();
    myFocusNode.removeListener(() {});
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageCOntroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: TextField(
                onSubmitted: (value) async {
                  if (value.isNotEmpty && value.trim() != '') {
                    myFocusNode.requestFocus();
                    // TODO: send the message here
                    await ChatServices().sendAMessage(
                      message: messageCOntroller!.text,
                      context: context,
                      friend: widget.freind,
                    );
                    messageCOntroller!.clear();
                  }
                  myFocusNode.requestFocus();
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
          ),
        ],
      ),
    );
  }
}
