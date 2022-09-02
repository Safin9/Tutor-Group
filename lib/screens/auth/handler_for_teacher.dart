import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/auth/sign_by_phone.dart';
import 'package:tutor_group/screens/home/home_screen.dart';

class HandlerScreenForTeacher extends StatelessWidget {
  const HandlerScreenForTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.data == null) {
            return SignInByPhone();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Teachers')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshotFromFuture) {
                  if (snapshotFromFuture.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshotFromFuture.hasError) {
                    return Center(
                      child: Text(snapshotFromFuture.error.toString()),
                    );
                  } else {
                    setUser(snapshot.data!, context);
                    return HomeScreen();
                  }
                });
//
          }
        }),
      ),
    );
  }

  Future setUser(User user, BuildContext context) async {
    UserModelReady theUser = await FirebaseFirestore.instance
        .collection('Teachers')
        .doc(user.uid)
        .get()
        .then((value) => UserModelReady.fromSnapShot(value));
    Provider.of<UserProvider>(context, listen: false).setUser(theUser);
  }
}
