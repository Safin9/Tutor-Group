import 'package:flutter/material.dart';
import 'package:tutor_group/utils/utils.dart';

class ToolsForLogAndSignup {
  Utils utils = Utils();

  Container buildTextField({
    String? hint,
    TextEditingController? controller,
    Function? validator,
    String? hintText,
    String? labelText,
    TextInputType? textInputType,
    Widget? icon,
    double? padding,
    required bool isobsecure,
  }) {
    return Container(
      width: double.infinity,
      height: 75,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 25),
      child: TextFormField(
        keyboardType: textInputType,
        validator: ((value) => validator!(value)),
        controller: controller,
        obscureText: isobsecure,
        decoration: InputDecoration(
          prefixIcon: icon,
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          labelText: labelText,
          helperText: '',
          filled: true,
          fillColor: Colors.white.withOpacity(0.5),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Text buldText(
      {required String text,
      required Color color,
      required double size,
      required FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: size,
      ),
    );
  }

  Container myBackgroundImage(Color color) {
    return Container(
      child: Image.asset(
        'assets/images/backgroundbook.png',
        color: color,
      ),
    );
  }

  TextButton myTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: Colors.orange[900]),
      ),
    );
  }

  Container buildButton({
    required VoidCallback onPressed,
    required Color color,
    required Widget child,
    required double heightP,
    required double widthP,
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(horizontal: widthP, vertical: heightP),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: child,
      ),
    );
  }
}
