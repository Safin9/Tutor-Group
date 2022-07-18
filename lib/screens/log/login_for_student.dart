import 'package:flutter/material.dart';
import 'package:tutor_group/utils/utils.dart';

class LoginForStudent extends StatefulWidget {
  const LoginForStudent({Key? key}) : super(key: key);

  @override
  State<LoginForStudent> createState() => _LoginForStudentState();
}

class _LoginForStudentState extends State<LoginForStudent> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Utils utils = Utils();
    return Scaffold(
      backgroundColor: utils.backgroundL,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: utils.textBlackL,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                        //FIXME: image here

                        )
                  ],
                )),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buldText(
                          text: 'Sign In',
                          color: utils.textBlackL,
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 0.09 * size.height,
                        ),
                        buildTextField(
                          hint: 'Email',
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 0.07 * size.height,
                        ),
                        buildTextField(
                          hint: 'Password',
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 0.07 * size.height,
                        ),
                        SizedBox(
                          height: 0.04 * size.height,
                        ),
                        buildButton(
                            onPressed: () {
                              print(_emailController!.text);
                              print(_passwordController!.text);
                              _emailController!.clear();
                              _passwordController!.clear();
                            },
                            color: utils.blueL,
                            child: const Text('Sign In'),
                            size: 0.2 * size.width),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextField({
    required String hint,
    required TextEditingController? controller,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Padding buldText(
      {required String text,
      required Color color,
      required double size,
      required FontWeight fontWeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontSize: size,
          ),
        ),
      ),
    );
  }

  Container buildButton({
    required VoidCallback onPressed,
    required Color color,
    required Widget child,
    required double size,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size, vertical: size),
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
