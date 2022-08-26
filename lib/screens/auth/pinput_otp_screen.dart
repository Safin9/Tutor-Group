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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.05 * size.height,
              ),
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
              SizedBox(
                height: 0.02 * size.height,
              ),
              const Text('Enter verification code down here'),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20),
                  child: Pinput(
                    length: 6,
                    focusNode: _pinOtpFocusNode,
                    controller: _pinOtpController,
                    onSubmitted: (value) {},
                    onCompleted: (pin) {
                      authServices.signInWithPhoneNumber(
                        verificationID: verificationCode!,
                        smsCode: pin,
                      );
                    },
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
