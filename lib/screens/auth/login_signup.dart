import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_group/screens/auth/login_for_teacher.dart';
import 'package:tutor_group/screens/auth/pinput_otp_screen.dart';
import 'package:tutor_group/screens/auth/signup_for_student.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/utils/utils.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: -6,
                right: 5,
                child: tools.myTextButton(
                  text: 'Teacher sign in?',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (contexdt) => const LogInForTeachre()));
                  },
                ),
              ),
              Positioned(
                  bottom: 0,
                  top: 150,
                  left: 0,
                  right: 0,
                  child: tools
                      .myBackgroundImage(utils.textGreyL.withOpacity(0.3))),
              Column(
                children: [
                  tools.buldText(
                      text: 'TUTOR',
                      color: utils.textBlackL,
                      size: 25,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 0.15 * size.height,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: LottieBuilder.network(
                        'https://assets5.lottiefiles.com/private_files/lf30_g4ft9Z.json'),
                  ),
                  tools.buldText(
                      text: 'Education leads to self illumination',
                      color: utils.textBlackL,
                      size: 15,
                      fontWeight: FontWeight.w400),
                  const Spacer(),
                  tools.buildButton(
                    onPressed: () {
                      Get.to(() => const SignUpForStudent());
                    },
                    color: utils.orangeL,
                    child: const Text('Sign Up'),
                    widthP: 0.2 * size.width,
                    heightP: 0,
                  ),
                  SizedBox(
                    height: 0.035 * size.height,
                  ),
                  tools.buldText(
                    text: '___   or   ___',
                    color: utils.textBlackL,
                    size: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 0.035 * size.height,
                  ),
                  tools.buildButton(
                      onPressed: () {
                        Get.to(const OtpScreen());
                      },
                      color: utils.blueL,
                      child: const Text('Sign In'),
                      heightP: 0,
                      widthP: 0.2 * size.width),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
