import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/auth/handler_screen.dart';
import 'package:tutor_group/screens/home/home_screen.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> createUserWithOtp({required String phoneNumber}) async {
    final sign = await auth.signInWithPhoneNumber(phoneNumber);
  }

  signInWithPhoneNumber(
      {required String verificationID, required String smsCode}) async {
    try {
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationID, smsCode: smsCode))
          .then((value) {
        if (value.user != null) {
          // FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).
          Get.offAll(() => const HandlerScreen());
        }
      });
    } catch (e) {
      Get.snackbar('Error with sign in', e.toString(),
          duration: const Duration(seconds: 60));
    }
  }

  createAccountWithEmailAndPasswordForUser(
      {required String email, required String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print('create account by E and P  $value.');

        Get.to(() => const HomeScreen());
        Get.dialog(const Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Text('welcome'),
          ),
        ));
      });
    } catch (e) {
      print('error with creating account$e');
    }
  }

  signInByEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.to(() => const HomeScreen());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('error with singing account$e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAll(() => const HandlerScreen()));
  }

// verificationphone() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+${context.read<TestProvider>().finalNumber}',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance
//             .signInWithCredential(credential)
//             .then((value) {
//           if (value.user != null) {
//             Get.offAll(() => const HomeScreen());
//           }
//         });
//       },
//       verificationFailed: ((FirebaseAuthException error) {
//         Get.snackbar('Error', error.toString(),
//             duration: const Duration(seconds: 120));
//         debugPrint(error.toString());
//       }),
//       codeSent: ((String vID, int? resendToken) {
//         setState(() {
//           verificationCode = vID;

//           // verificationId = verificationCode!;
//         });
//       }),
//       codeAutoRetrievalTimeout: ((String verificationId) {
//         setState(() {
//           verificationCode = verificationId;
//         });
//       }),
//       timeout: const Duration(seconds: 120),
//     );
//   }
//   Future<void> verifyByOtp() async{
// final sign=await auth.verifyPhoneNumber(
//   verificationCompleted: verificationCompleted,
//   verificationFailed: verificationFailed,
//   codeSent: codeSent,
//   codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
//   }
}
