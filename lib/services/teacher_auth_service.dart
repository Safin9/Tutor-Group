import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/home/home_screen.dart';

class TeacherAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  creatAccount({required String email, required String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar('success', 'Successfuly created');
      });
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  signIn({required String email, required String password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar('success', 'Logged in');
        Get.offAll(() => const HomeScreen());
      });
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
