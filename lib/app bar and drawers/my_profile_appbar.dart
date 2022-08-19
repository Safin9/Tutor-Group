import 'package:flutter/material.dart';

PreferredSizeWidget myHomeAppBar({
  required String title,
  required Color backgroundColor,
  List<Widget>? actions,
  required Color titleColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: actions,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}
