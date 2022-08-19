import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/my_custom_themes.dart';
import 'package:tutor_group/providers/phone_code_provider.dart';
import 'package:tutor_group/screens/auth/pinput_otp_screen.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';

class SignInByPhone extends StatelessWidget {
  SignInByPhone({Key? key}) : super(key: key);
  final TextEditingController numberContorller = TextEditingController();
  final numberFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();

    return Scaffold(
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
                    const SizedBox(height: 150),
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
                          ].contains(country.isoCode)),
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      onValuePicked: ((value) {
                        final code = context
                            .read<TestProvider>()
                            .method(number: int.parse(value.phoneCode));
                        // setState(() {
                        //   phoneCode = value.phoneCode;
                        //   print(phoneCode);
                        // });
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
                              return 'Enter a number';
                            } else if (val.length < 10) {
                              return 'Please Enter a valid number';
                            }
                            return null;
                          } else {
                            if (val.trim().isEmpty) {
                              return 'Enter a number';
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
                          debugPrint(numberContorller.text.trim());

                          context.read<TestProvider>().finalPhoneNumber(
                                number: numberContorller.text.trim(),
                              );

                          Get.to(() => const OtpScreen());
                          numberContorller.clear();
                        }
                      },
                      color: utils.orangeL,
                      child: const Text('Verify'),
                      heightP: 100,
                      widthP: 0,
                      width: 250,
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
