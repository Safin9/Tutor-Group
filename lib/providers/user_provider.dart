import 'package:flutter/material.dart';

import 'package:tutor_group/modules/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModelReady? theUser;

  setUser(UserModelReady user) {
    theUser = user;
    debugPrint('from provider : $theUser');
    notifyListeners();
  }
}
