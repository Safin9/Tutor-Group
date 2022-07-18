import 'package:flutter/material.dart';

class LogInForTeachre extends StatelessWidget {
  const LogInForTeachre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in for teacher'),
      ),
    );
  }

  Container buildTextField({
    required String hint,
    required Color color,
    required double size,
    required TextEditingController? controller,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: color,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}
