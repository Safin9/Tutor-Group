import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/providers/phone_code_provider.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/screens/home_screen.dart';
import 'package:tutor_group/services/auth_services.dart';
import 'package:tutor_group/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController? _pinOtpController;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  FocusNode? _pinOtpFocusNode;
  String? verificationCode;
  AuthServices authServices = AuthServices();
  Utils utils = Utils();
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();

  @override
  void initState() {
    _pinOtpController = TextEditingController();
    _pinOtpFocusNode = FocusNode();
    debugPrint(context.read<TestProvider>().finalNumber);
    verificationphone();
    super.initState();
  }

  @override
  void dispose() {
    _pinOtpController!.dispose();
    _pinOtpFocusNode!.dispose();
    super.dispose();
  }

  verificationphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${context.read<TestProvider>().finalNumber}',
      verificationCompleted: (credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Get.offAll(() => const HomeScreen());
          }
        });
      },
      verificationFailed: ((error) {
        Get.snackbar('Error', error.toString(),
            duration: const Duration(seconds: 60));
        debugPrint(error.toString());
      }),
      codeSent: ((vID, resendToken) {
        setState(() {
          verificationCode = vID;

          // verificationId = verificationCode!;
        });
      }),
      codeAutoRetrievalTimeout: ((verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      }),
      timeout: const Duration(seconds: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //this is full number:
    final phoneNumber = Provider.of<TestProvider>(context).finalNumber!;
    //this is code:
    final code = Provider.of<TestProvider>(context).n;
    //this is number
    final number = Provider.of<TestProvider>(context).phonenumber!;

    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned(
            //   top: 7,
            //   left: 7,
            //   child: IconButton(
            //     highlightColor: Colors.grey.withOpacity(0.05),
            //     splashColor: Colors.transparent,
            //     onPressed: () {
            //       Get.back();
            //     },
            //     icon: Icon(Platform.isAndroid
            //         ? Icons.arrow_back
            //         : Icons.arrow_back_ios),
            //   ),
            // ),
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(),
                      SelectableText(
                        'Verifying  +$code  $number',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: (() {
                            Get.back();
                            context.read<TestProvider>().n = 964;
                          }),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: const FaIcon(
                            FontAwesomeIcons.pencil,
                            size: 17,
                          )),
                      const Spacer(),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Pinput(
                        length: 6,
                        focusNode: _pinOtpFocusNode,
                        controller: _pinOtpController,
                        // onTap: () {
                        //   _pinOtpController!.clear();
                        // },
                        onSubmitted: (value) {},
                        onCompleted: (pin) {
                          // verificationCode = pin;
//FIXME:
                          authServices.signInWithPhoneNumber(
                            verificationID: verificationCode!,
                            smsCode: pin,
                          );
                          print("verification code: ${verificationCode!}");
                          print(pin);
                        },
                      ),
                    ),
                  ),

                  // tools.buildButton(
                  //   onPressed: ()  {
                  //     // Get.offAll(() => const HomeScreen());

                  //   },
                  //   color: utils.blueL,
                  //   child: const Text('Sign In'),
                  //   heightP: 0,
                  //   widthP: 0.2 * size.width,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
