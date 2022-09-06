import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/providers/phone_code_provider.dart';
import 'package:tutor_group/screens/auth/login_for_teacher.dart';
import 'package:tutor_group/screens/auth/pinput_otp_screen.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/utils/utils.dart';

class SignInByPhone extends StatelessWidget {
  SignInByPhone({Key? key}) : super(key: key);
  final TextEditingController numberContorller = TextEditingController();
  final numberFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: tools.buldText(
            text: 'TUTOR', size: 25, fontWeight: FontWeight.bold),
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
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Form(
                key: numberFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: LottieBuilder.asset('assets/lottie/teacher.json'),
                    ),
                    const SizedBox(height: 50),
                    tools.buldText(
                      text: 'Education leads to self illumination',
                      size: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 25),
                    CountryPickerDropdown(
                      initialValue: 'IQ',
                      itemFilter: ((country) => [
                            'CA',
                            'US',
                            'IQ',
                            'SA',
                            'KW',
                            'AE',
                            'RE',
                            'SE',
                            'DE',
                            'IR',
                            'QA',
                            'CN',
                            'IN',
                            'GB',
                          ].contains(country.isoCode)),
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      onValuePicked: ((value) {
                        context
                            .read<TestProvider>()
                            .method(number: int.parse(value.phoneCode));
                      }),
                      sortComparator: (a, b) =>
                          a.phoneCode.compareTo(b.phoneCode),
                    ),
                    SizedBox(
                      width: 250,
                      child: tools.buildTextField(
                        textInputType: const TextInputType.numberWithOptions(),
                        padding: 0,
                        validator: (val) {
                          final phoneCode = context.read<TestProvider>().n;
                          if (phoneCode == 964) {
                            if (val.trim().isEmpty) {
                              return 'enter a number';
                            } else if (val.length < 10) {
                              return 'enter a valid number';
                            }
                            return null;
                          } else {
                            if (val.trim().isEmpty) {
                              return 'enter a number';
                            }
                            return null;
                          }
                        },
                        hintText: 'hintText',
                        controller: numberContorller,
                        labelText: 'Phone',
                        isobsecure: false,
                      ),
                    ),
                    tools.buildButton(
                      onPressed: () {
                        bool isvalid = numberFormKey.currentState!.validate();

                        if (isvalid) {
                          context.read<TestProvider>().finalPhoneNumber(
                                number: numberContorller.text.trim(),
                              );

                          Get.to(
                            () => const OtpScreen(),
                          );
                          numberContorller.clear();
                        }
                      },
                      color: textBlackL,
                      child: Row(
                        children: const [
                          FaIcon(FontAwesomeIcons.phone),
                          Spacer(),
                          Text('Continue with phone'),
                          Spacer(),
                        ],
                      ),
                      heightP: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
