import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_group/utils/utils.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

// final kTitleTextStyle = TextStyle(
//   fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
//   fontWeight: FontWeight.w600,
// );

// final kCaptionTextStyle = TextStyle(
//   fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
//   fontWeight: FontWeight.w100,
// );

// final kButtonTextStyle = TextStyle(
//   fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
//   fontWeight: FontWeight.w400,
//   color: kDarkPrimaryColor,
// );
final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: backgroundD,
  primaryColor: Colors.amber,
  dividerColor: Colors.white.withOpacity(0.5),
  appBarTheme: const AppBarTheme().copyWith(
    actionsIconTheme: const IconThemeData().copyWith(
      color: textWhiteD,
    ),
    backgroundColor: backgroundD,
    titleTextStyle:
        TextStyle(color: textWhiteD, fontSize: 22, fontWeight: FontWeight.bold),
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
);
final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: backgroundL,
  splashColor: Colors.transparent,
  dividerColor: Colors.black.withOpacity(0.5),
  appBarTheme: const AppBarTheme().copyWith(
    actionsIconTheme: const IconThemeData().copyWith(
      color: textBlackL,
    ),
    titleTextStyle:
        TextStyle(color: textBlackL, fontSize: 22, fontWeight: FontWeight.bold),
    backgroundColor: backgroundL,
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
);
final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  appBarTheme: const AppBarTheme()
      .copyWith(backgroundColor: Colors.transparent, elevation: 0),
  backgroundColor: kDarkSecondaryColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);
