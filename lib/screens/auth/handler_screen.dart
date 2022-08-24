import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/auth/login_signup.dart';
import 'package:tutor_group/screens/auth/signup_for_student.dart';
import 'package:tutor_group/screens/home_screen.dart';

class HandlerScreen extends StatefulWidget {
  const HandlerScreen({Key? key}) : super(key: key);

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? theUser;

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
            return LogIn();
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
                  print('not exist should signup');
                  return const SignUpForStudent();
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: ((b) => const SignUpForStudent())));
                } else {
                  return const HomeScreen();
                }
              });
        },
      ),
    );
  }

  Future<UserModel> getUser(User user) async {
    UserModel theUser = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get()
        .then((value) => UserModel.fromSnapShot(value));

    Provider.of<UserProvider>(context, listen: false).setWeCodeUser(theUser);

    return theUser;
  }
}
