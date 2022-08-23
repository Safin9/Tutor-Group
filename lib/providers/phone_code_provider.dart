import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  int n = 964;
  String? finalNumber;
  String? phonenumber;
  String? verificationCode;
  method({required int number}) {
    n = number;
    debugPrint('from provider: $n');
    notifyListeners();
  }

  String finalPhoneNumber({required String number}) {
    finalNumber = n.toString() + number;
    phonenumber = number;
    debugPrint('from provider full number: $finalNumber ');
    debugPrint('from provider code: $n');
    debugPrint('from provider number: $number ');

    notifyListeners();
    return finalNumber!;
  }

  phoneVerificationCode({required String vCode}) {
    verificationCode = vCode;
    notifyListeners();
  }
}
