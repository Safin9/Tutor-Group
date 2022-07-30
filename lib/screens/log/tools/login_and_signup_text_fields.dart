import 'package:flutter/material.dart';
import 'package:tutor_group/utils/utils.dart';

class ToolsForLogAndSignup {
  Utils utils = Utils();

  Container buildTextField({
    required String hint,
    TextEditingController? controller,
    required Function? validator,
    required String hintText,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: ((value) => validator!(value)),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.65),
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

  Container buildButton(
      {required VoidCallback onPressed,
      required Color color,
      required Widget child,
      required double heightP,
      required double widthP}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: widthP, vertical: heightP),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: child,
      ),
    );
  }
}
