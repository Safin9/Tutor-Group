import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/chats/chat_page.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({Key? key, required this.friendUser})
      : super(key: key);
  final UserModelReady friendUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        Get.to(() => ChatPage(
              friendUser: friendUser,
            ));
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      width: 4, color: Color.fromARGB(255, 19, 97, 160))))),
      child: Text(
        'Send message',
        style: TextStyle(
            fontSize: 0.037 * size.width,
            color: const Color.fromARGB(255, 28, 105, 168)),
      ),
    );
  }
}
