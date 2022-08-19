import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  int n = 964;
  String? finalNumber;
  String? phonenumber;
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

  // fullnumber({required String numb}) {
  //   finalNumber = numb;
  //   finalNumber = n.toString() + numb;
  //   debugPrint('from provider full number: $finalNumber ');
  //   notifyListeners();
  //   debugPrint('from provider code: $n');
  //   debugPrint('from provider number: $numb ');
  // }
}
