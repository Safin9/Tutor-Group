import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.send,
                      onSubmitted: ((value) {
                        print(value);
                      }),
                      keyboardAppearance:
                          Get.isDarkMode ? Brightness.dark : Brightness.light,
                      decoration: const InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(color: Color(0xFF1B97F3)),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                        color: Color(0xFF1B97F3), shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
