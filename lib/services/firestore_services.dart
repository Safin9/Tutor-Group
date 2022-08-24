import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/handler_screen.dart';

class FireStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  addUserToDBWithInformationUsers({required UserModel userModel}) async {
    try {
      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set(userModel.toMap())
          .then((value) => Get.offAll(() => const HandlerScreen()));
    } catch (e) {}
  }
}
