import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/handler_screen.dart';
import 'package:tutor_group/utils/constant.dart';

class FireStoreService {
  addUserToDBWithInformationUsers({required UserModelReady userModel}) async {
    try {
      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set(userModel.toMap())
          .then((value) => Get.offAll(() => const HandlerScreen()));
    } catch (e) {
      Get.snackbar('Error ', 'From Adding user informations');
    }
  }
}
