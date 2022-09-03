import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModelReady currentUser = context.read<UserProvider>().theUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
