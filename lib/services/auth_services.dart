import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> createUserWithOtp({required String phoneNumber}) async {
    final sign = await auth.signInWithPhoneNumber(phoneNumber);
  }

//   Future<void> verifyByOtp() async{
// final sign=await auth.verifyPhoneNumber(
//   verificationCompleted: verificationCompleted,
//   verificationFailed: verificationFailed,
//   codeSent: codeSent,
//   codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
//   }
}
