import 'package:flutter/material.dart';
import 'package:tutor_group/modules/user1_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? theUser;

  setUser(UserModel user) {
    theUser = user;
    debugPrint('from provider : $theUser');
    notifyListeners();
  }
}
