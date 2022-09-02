import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/auth/sign_by_phone.dart';
import 'package:tutor_group/screens/auth/signup_for_student.dart';
import 'package:tutor_group/screens/home/home_screen.dart';

class HandlerScreen extends StatefulWidget {
  const HandlerScreen({Key? key}) : super(key: key);

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModelReady? theUser;

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth(auth service) =>
    // FirebaseFirestore(database service) =>
    // save it on a global object as provider to use it on all the app sections

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.data == null) {
            return SignInByPhone();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          // return const HomeScreen();
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(auth.currentUser!.uid)
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
                } else if (snapshotFromFuture.data == null ||
                    !snapshotFromFuture.data!.exists) {
                  return const SignUpForStudent();
                } else {
                  setUser(user: snapshot.data!, context: context);
                  return HomeScreen();
                }
              });
        },
      ),
    );
  }

  Future setUser({required User user, required BuildContext context}) async {
    UserModelReady theUser = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get()
        .then((value) => UserModelReady.fromSnapShot(value));

    Provider.of<UserProvider>(context, listen: false).setUser(theUser);
  }
}
