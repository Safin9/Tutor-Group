import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tutor_group/screens/home_screen.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _pinOtpController;
  FocusNode? _pinOtpFocusNode;
  String? verificationCode;
  Utils utils = Utils();
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();

  @override
  void initState() {
    _pinOtpController = TextEditingController();
    _pinOtpFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _pinOtpController!.dispose();
    _pinOtpFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 7,
              left: 7,
              child: IconButton(
                highlightColor: Colors.grey.withOpacity(0.05),
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Platform.isAndroid
                    ? Icons.arrow_back
                    : Icons.arrow_back_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'OTPs',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Verifying  ${widget.phone}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Pinput(
                        length: 6,
                        focusNode: _pinOtpFocusNode,
                        controller: _pinOtpController,
                        onTap: () {
                          _pinOtpController!.clear();
                        },
                        onSubmitted: (value) {
                          print(value);
                          _pinOtpController!.clear();
                        },
                        onCompleted: (value) {
                          print(value);
                        },
                      ),
                    ),
                  ),
                  tools.buildButton(
                      onPressed: () {
                        if (_pinOtpController!.value.text == '000000') {
                          Get.to(() => const HomeScreen());
                        } else {
                          print(_pinOtpController!.value.text);
                          print('error');
                        }
                      },
                      color: utils.blueL,
                      child: const Text('Sign In'),
                      heightP: 0,
                      widthP: 0.2 * size.width),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
