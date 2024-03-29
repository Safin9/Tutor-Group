import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/screens/auth/handler_for_teacher.dart';
import 'package:tutor_group/screens/auth/handler_screen.dart';
import 'package:tutor_group/screens/auth/sign_by_phone.dart';
import 'package:tutor_group/widgets/loading_for_firstpage.dart';

class MainHandler extends StatelessWidget {
  const MainHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingForFirstPage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData && snapshot.data == null) {
            return SignInByPhone();
          }
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Teachers')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshotFromFuture) {
                if (snapshotFromFuture.connectionState ==
                    ConnectionState.waiting) {
                  return const LoadingForFirstPage();
                } else if (snapshotFromFuture.hasError) {
                  return Center(
                    child: Text(snapshotFromFuture.error.toString()),
                  );
                } else if (snapshotFromFuture.data == null ||
                    !snapshotFromFuture.data!.exists) {
                  return const HandlerScreen();
                } else {
                  return const HandlerScreenForTeacher();
                }
              });
        }),
      ),
    );
  }
}
