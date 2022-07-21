import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_group/utils/utils.dart';

import 'tools/login_and_signup_text_fields.dart';

class LogInForTeachre extends StatefulWidget {
  const LogInForTeachre({Key? key}) : super(key: key);

  @override
  State<LogInForTeachre> createState() => _LogInForTeachreState();
}

class _LogInForTeachreState extends State<LogInForTeachre> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  final _loginFormKey = GlobalKey<FormState>();
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
                top: 0.04 * size.height,
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
                      text: 'Teacher Sign In',
                      color: utils.textBlackL,
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            tools.buildTextField(
                              hint: 'Email',
                              controller: _emailController,
                              validator: (value) {
                                String p =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(p);

                                if (!value.isEmpty &&
                                    value.length > 6 &&
                                    regExp.hasMatch(value)) {
                                  return null;
                                }
                                return 'Please enter your email';
                              },
                              hintText: '',
                            ),
                            SizedBox(
                              height: 0.07 * size.height,
                            ),
                            tools.buildTextField(
                                hint: 'Password',
                                controller: _passwordController,
                                validator: (value) {
                                  if (!value.isEmpty) {
                                    return null;
                                  }
                                  return 'Please enter your password';
                                },
                                hintText: ''),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.07 * size.height,
                      ),
                      tools.buildButton(
                        onPressed: () {
                          bool isvalid = _loginFormKey.currentState!.validate();
                          if (isvalid) {
                            print(isvalid);
                            print(_emailController!.text);

                            print(_passwordController!.text);

                            _emailController!.clear();
                            _passwordController!.clear();
                          } else {
                            print('error');
                          }
                        },
                        color: utils.blueL,
                        child: const Text('Sign In'),
                        widthP: 0.2 * size.width,
                        heightP: 0.2 * size.width,
                      ),
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
