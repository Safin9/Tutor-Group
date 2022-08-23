import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/auth/login_for_teacher.dart';
import 'package:tutor_group/screens/auth/sign_by_phone.dart';
import 'package:tutor_group/screens/auth/signup_for_student.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/services/auth_services.dart';
import 'package:tutor_group/utils/utils.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  ToolsForLogAndSignup tools = ToolsForLogAndSignup();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: tools.buldText(
            text: 'TUTOR',
            color: utils.textBlackL,
            size: 25,
            fontWeight: FontWeight.bold),
        actions: [
          tools.myTextButton(
            text: 'Teacher sign in?',
            onPressed: () {
              Get.to(() => const LogInForTeachre());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  tools.buldText(
                    text: 'Education leads to self illumination',
                    color: utils.textBlackL,
                    size: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 0.2 * size.height,
                  ),
                  tools.buildTextField(
                    hint: '',
                    controller: emailController,
                    isobsecure: false,
                    labelText: 'email',
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
                    height: 0.007 * size.height,
                  ),
                  tools.buildTextField(
                    isobsecure: false,
                    controller: passwordController,
                    hint: '',
                    labelText: 'password',
                    validator: (value) {
                      if (!value.isEmpty) {
                        return null;
                      }
                      return 'Please enter your password';
                    },
                    hintText: '',
                  ),
                  tools.buildButton(
                    onPressed: () {
                      bool isvalid = formkey.currentState!.validate();
                      if (isvalid) {
                        AuthServices().signInByEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    color: utils.blueL,
                    child: const Text('Sign In'),
                    heightP: 0,
                    widthP: 0.2 * size.width,
                  ),
                  SizedBox(
                    height: 0.01 * size.height,
                  ),
                  tools.buildButton(
                    onPressed: () {
                      Get.to(() => const SignUpForStudent());
                    },
                    color: utils.orangeL,
                    child: const Text('Sign Up'),
                    width: 150,
                    widthP: 0.02 * size.width,
                  ),
                  tools.buldText(
                    text: '___   or   ___',
                    color: utils.textBlackL,
                    size: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 0.010 * size.height,
                  ),
                  tools.buildButton(
                    onPressed: () {
                      Get.to(() => SignInByPhone());
                    },
                    color: utils.textBlackL,
                    child: Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.phone),
                        Spacer(),
                        Text('sign by phone'),
                        Spacer(),
                      ],
                    ),
                    // widthP: 0.2 * size.width,
                    heightP: 0,
                  ),
                  SizedBox(
                    height: 0.015 * size.height,
                  ),
                  // tools.buildButton(
                  //   onPressed: () {
                  //     // Get.to(() => SignInByPhone());
                  //   },
                  //   color: utils.textBlackL,
                  //   child: Row(
                  //     children: const [
                  //       FaIcon(
                  //         FontAwesomeIcons.google,
                  //         color: Colors.red,
                  //       ),
                  //       Spacer(),
                  //       Text('Countine with google'),
                  //       Spacer(),
                  //     ],
                  //   ),
                  //   widthP: 0.2 * size.width,
                  //   heightP: 0,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
