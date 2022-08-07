import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/screens/log/tools/login_and_signup_text_fields.dart';

class SignUpForStudent extends StatefulWidget {
  const SignUpForStudent({Key? key}) : super(key: key);

  @override
  State<SignUpForStudent> createState() => _SignUpForStudentState();
}

class _SignUpForStudentState extends State<SignUpForStudent> {
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? userNameController;
  TextEditingController? passwordConfirmController;
  final signUpFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passwordConfirmController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
    userNameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              // Positioned.fill(
              //   child: Image.asset(
              //     'assets/images/backgroundbook.png',
              //     color: tools.utils.textGreyL.withOpacity(0.1),
              //   ),
              // ),
              // Positioned(
              //   bottom: 0.12 * size.height,
              //   left: 0.1 * size.width,
              //   right: 0.1 * size.width,
              //   child: LottieBuilder.network(
              //     'https://assets1.lottiefiles.com/packages/lf20_gyiysecz.json',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: tools.utils.textBlackL,
                        size: 30,
                      ),
                    ),
                    tools.buldText(
                      text: 'Sign Up',
                      color: tools.utils.textBlackL,
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
                      Form(
                        key: signUpFormKey,
                        child: Column(
                          children: [
                            tools.buildTextField(
                              hintText: '',
                              labelText: 'user name',
                              controller: userNameController,
                              textInputType: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              hint: '',
                            ),
                            SizedBox(height: 0.001 * size.height),
                            tools.buildTextField(
                              hint: '',
                              labelText: 'email',
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
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
                            SizedBox(height: 0.001 * size.height),
                            tools.buildTextField(
                              hint: '',
                              labelText: 'password',
                              textInputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              validator: (value) {
                                if (!value.isEmpty) {
                                  return null;
                                }
                                return 'Please enter your password';
                              },
                              hintText: '',
                            ),
                            SizedBox(height: 0.001 * size.height),
                            tools.buildTextField(
                                textInputType: TextInputType.visiblePassword,
                                hint: '',
                                labelText: 're-enter password',
                                controller: passwordConfirmController,
                                validator: (value) {
                                  if (value == passwordController!.text) {
                                    return null;
                                  }
                                  return 'password does not match';
                                },
                                hintText: ''),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.001 * size.height),
                      tools.buildButton(
                        onPressed: () {
                          bool isvalid = signUpFormKey.currentState!.validate();
                          if (isvalid) {
                            print(isvalid);
                            print("email: ${emailController!.text}");

                            print('pass: ${passwordController!.text}');
                            print("username: ${userNameController!.text}");

                            emailController!.clear();
                            passwordController!.clear();
                            userNameController!.clear();
                            passwordConfirmController!.clear();
                          } else {
                            print('error');
                          }
                        },
                        color: tools.utils.orangeL,
                        child: const Text('Sign Up'),
                        widthP: 0.1 * size.width,
                        heightP: 0.1 * size.width,
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
