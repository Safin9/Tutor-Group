import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/main.dart';

class Utils {
  final bool isDark = storage.read('isDark');

  Color blueD = const Color.fromARGB(255, 69, 173, 255);
  Color greenD = const Color.fromARGB(255, 115, 255, 224);
  Color orangeD = const Color.fromARGB(255, 255, 137, 117);
  Color blueL = const Color.fromARGB(255, 0, 143, 255);
  Color greenL = const Color.fromARGB(255, 80, 227, 194);
  Color orangeL = const Color.fromARGB(255, 255, 84, 54);

  Color backgroundD = const Color.fromARGB(255, 45, 55, 72);
  Color backgroundL = const Color.fromARGB(255, 238, 242, 247);

  Color textBlackL = const Color.fromARGB(255, 45, 55, 72);
  Color textGreyL = const Color.fromARGB(255, 74, 85, 103);
  Color textBlueL = const Color.fromARGB(255, 43, 108, 176);

  Color textWhitekD = const Color.fromARGB(255, 249, 251, 253);
  Color textGreyD = const Color.fromARGB(255, 222, 226, 234);
  Color textGreenD = const Color.fromARGB(255, 129, 230, 217);
}
