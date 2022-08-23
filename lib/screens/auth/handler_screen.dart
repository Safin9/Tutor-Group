import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/login_signup.dart';

class HandlerScreen extends StatefulWidget {
  const HandlerScreen({Key? key}) : super(key: key);

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? thWecodeUser;

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth(auth service) =>
    // FirebaseFirestore(database service) =>
    // save it on a global object as provider to use it on all the app sections

    return Scaffold(
        body: StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              //TODO:  check if loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              } else if (snapshot.data == null) {
                return LogIn();
              } else if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }
              return LogIn();
              //         return FutureBuilder<UserModel>(
              //             future: getUser(snapshot.data!),
              //             builder: (context, snapshotFromFuture) {
              //               if (snapshotFromFuture.connectionState ==
              //                   ConnectionState.waiting) {
              //                 return const CircularProgressIndicator.adaptive();
              //               } else if (snapshotFromFuture.hasError) {
              //                 return Center(
              //                   child: Text(snapshotFromFuture.error.toString()),
              //                 );
              //               } else if (snapshotFromFuture.data == null) {
              //                 //TODO: go to create Profile

              //                 Get.to(() => const SignUpForStudent());
              //               }
              //               return const HomeScreen();
              //             });
              //       },
              //     ),
              //   );
              // }

              // Future<UserModel> getUser(User user) async {
              //   UserModel theUser = await FirebaseFirestore.instance
              //       .collection('users')
              //       .doc(user.uid)
              //       .get()
              //       .then((value) => UserModel.fromSnapShot(value));

              //   Provider.of<UserProvider>(context, listen: false).setWeCodeUser(theUser);

              //   return theUser;
              // }
            }));
  }
}
