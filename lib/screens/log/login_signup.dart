import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_group/screens/log/login_for_student.dart';
import 'package:tutor_group/screens/log/login_for_teacher.dart';
import 'package:tutor_group/utils/utils.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
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
                child: myTextButton(
                    text: 'Teacher sign in?',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (contexdt) => const LogInForTeachre()));
                    }),
              ),
              Positioned(
                  bottom: 0,
                  top: 150,
                  left: 0,
                  right: 0,
                  child: myBackgroundImage(utils.textGreyL.withOpacity(0.3))),
              Expanded(
                child: Column(
                  children: [
                    buldText(
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
                    buldText(
                        text: 'Education leads to self illumination',
                        color: utils.textBlackL,
                        size: 15,
                        fontWeight: FontWeight.w400),
                    const Spacer(),
                    buildButton(
                        onPressed: () {},
                        color: utils.orangeL,
                        child: const Text('Sign Up'),
                        size: 0.2 * size.width),
                    SizedBox(
                      height: 0.035 * size.height,
                    ),
                    buldText(
                      text: '___   or   ___',
                      color: utils.textBlackL,
                      size: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 0.035 * size.height,
                    ),
                    buildButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginForStudent()));
                        },
                        color: utils.blueL,
                        child: const Text('Sign In'),
                        size: 0.2 * size.width),
                  ],
                ),
              ),
            ],
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
      padding: EdgeInsets.symmetric(horizontal: size),
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

  Text buldText(
      {required String text,
      required Color color,
      required double size,
      required FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        background: Paint()..color = Colors.white.withOpacity(0.6),
        fontWeight: fontWeight,
        color: color,
        fontSize: size,
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
        style: TextStyle(fontSize: 12, color: Colors.orange[900]),
      ),
    );
  }
}
