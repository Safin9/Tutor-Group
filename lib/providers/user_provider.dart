import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? weCodeUser;

  setWeCodeUser(UserModel user) {
    weCodeUser = user;
    debugPrint('from provider : $weCodeUser');
    notifyListeners();
  }
}
