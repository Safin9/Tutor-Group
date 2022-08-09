import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_group/utils/utils.dart';

import 'tools/login_and_signup_text_fields.dart';

class LoginForStudent extends StatefulWidget {
  const LoginForStudent({Key? key}) : super(key: key);

  @override
  State<LoginForStudent> createState() => _LoginForStudentState();
}

class _LoginForStudentState extends State<LoginForStudent> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/backgroundbook.png',
                  color: utils.textGreyL.withOpacity(0.2),
                ),
              ),
              Positioned(
                bottom: 0.08 * size.height,
                left: 0.1 * size.width,
                right: 0.1 * size.width,
                child: LottieBuilder.network(
                  'https://assets9.lottiefiles.com/packages/lf20_jcikwtux.json',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: utils.textBlackL,
                        size: 30,
                      ),
                    ),
                    tools.buldText(
                      text: 'Sign In',
                      color: utils.textBlackL,
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0.1 * size.height,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tools.buildTextField(
                        hint: '',
                        isobsecure: false,
                        labelText: 'email',
                        controller: _emailController,
                        validator: null,
                        hintText: '',
                      ),
                      SizedBox(
                        height: 0.07 * size.height,
                      ),
                      tools.buildTextField(
                        hint: '',
                        isobsecure: false,
                        labelText: 'password',
                        controller: _passwordController,
                        validator: null,
                        hintText: '',
                      ),
                      SizedBox(
                        height: 0.4 * size.height,
                      ),
                      tools.buildButton(
                          onPressed: () {
                            print(_emailController!.text);

                            print(_passwordController!.text);
                            _emailController!.clear();
                            _passwordController!.clear();
                          },
                          color: utils.blueL,
                          child: const Text('Sign In'),
                          widthP: 0.2 * size.width,
                          heightP: 0.2 * size.width),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
