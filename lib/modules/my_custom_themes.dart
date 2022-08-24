import 'package:flutter/material.dart';
import 'package:tutor_group/utils/utils.dart';

final utils = Utils();

class MyThemes {
  ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: utils.backgroundD,
    primaryColor: Colors.amber,
    dividerColor: Colors.white.withOpacity(0.5),
    appBarTheme: const AppBarTheme().copyWith(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
  );
  ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: utils.backgroundL,
    splashColor: Colors.transparent,
    dividerColor: Colors.black.withOpacity(0.5),
    appBarTheme: const AppBarTheme().copyWith(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
  );
}
