import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/services/auth_services.dart';
import 'package:tutor_group/services/firestore_services.dart';

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
                              isobsecure: false,
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
                              isobsecure: false,
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
                              isobsecure: false,
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
                                isobsecure: false,
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
                        onPressed: () async {
                          bool isvalid = signUpFormKey.currentState!.validate();
                          if (isvalid) {
                            await AuthServices()
                                .createAccountWithEmailAndPasswordForUser(
                                    email: emailController!.text.trim(),
                                    password: passwordController!.text);
                            FireStoreService().addUserToDBWithInformationUsers(
                                userModel: UserModel(
                                    name: userNameController!.text,
                                    createdAt: DateTime.now(),
                                    birthDate: DateTime.now()
                                        .subtract(const Duration(days: 365)),
                                    currentCity: 'Duhok',
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    phone: '7807050300',
                                    surName: 'Saber',
                                    languages: [
                                  'Kurdish',
                                  'English',
                                  'Arabic'
                                ]));
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
