import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/auth/handler_for_teacher.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: tools.buldText(
          text: 'Teacher Sign In',
          color: Get.isDarkMode ? textWhiteD : textBlackL,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0.2 * size.height),
                  tools.buildTextField(
                    hint: '',
                    isobsecure: false,
                    labelText: 'email',
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
                  tools.buildTextField(
                      isobsecure: false,
                      hint: '',
                      labelText: 'password',
                      controller: _passwordController,
                      validator: (value) {
                        if (!value.isEmpty) {
                          return null;
                        }
                        return 'Please enter your password';
                      },
                      hintText: ''),
                  tools.buildButton(
                    onPressed: () async {
                      bool isvalid = _loginFormKey.currentState!.validate();
                      if (isvalid) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController!.text.trim(),
                                  password: _passwordController!.text)
                              .then((value) {
                            // TODO: create a handler screen for teacher
                            // final user=UserModelReady.fromSnapShot(value.)
                            // Provider.of<UserProvider>(context).setUser(user)
                            Get.snackbar('success', 'Logged in');
                            Get.offAll(() => const HandlerScreenForTeacher());
                          });
                        } catch (e) {
                          Get.snackbar('error', e.toString());
                        }

                        _emailController!.clear();
                        _passwordController!.clear();
                      } else {}
                    },
                    color: blueL,
                    child: const Text('Sign In'),
                    widthP: 0.2 * size.width,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
