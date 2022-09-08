import 'package:flutter/material.dart';

class PhoneCodeAndNumberProvider extends ChangeNotifier {
  int n = 964;
  String? finalNumber;
  String? phonenumber;
  String? verificationCode;
  method({required int number}) {
    n = number;

    notifyListeners();
  }

  String finalPhoneNumber({required String number}) {
    finalNumber = n.toString() + number;
    phonenumber = number;

    notifyListeners();
    return finalNumber!;
  }

  phoneVerificationCode({required String vCode}) {
    verificationCode = vCode;
    notifyListeners();
  }
}
