import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/birthdate_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:tutor_group/services/firestore_services.dart';
import 'package:tutor_group/utils/constant.dart';
import 'package:tutor_group/utils/general_dropdown.dart';
import 'package:tutor_group/utils/strings.dart';
import 'package:intl/intl.dart';
import '../../utils/utils.dart';

class SignUpForStudent extends StatefulWidget {
  const SignUpForStudent({Key? key}) : super(key: key);

  @override
  State<SignUpForStudent> createState() => _SignUpForStudentState();
}

class _SignUpForStudentState extends State<SignUpForStudent> {
  ToolsForLogAndSignup tools = ToolsForLogAndSignup();

  TextEditingController? userNameController;
  TextEditingController? surnameController;

  final signUpFormKey = GlobalKey<FormState>();

  String selectedDay = '0';
  String selectedMonth = '0';
  String selectedYear = '0';

  String selectedCity = 'Duhok';
  String selectedGender = 'Male';
  Numbers n = Numbers();
  @override
  void initState() {
    userNameController = TextEditingController();
    surnameController = TextEditingController();
    n.methods();
    super.initState();
  }

  @override
  void dispose() {
    userNameController!.dispose();
    surnameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToolsForLogAndSignup tools = ToolsForLogAndSignup();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: textBlackL,
            size: 20,
          ),
        ),
        title: tools.buldText(
          text: 'Sign Up',
          color: textBlackL,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  // FIXME: complete the signup for student
                  key: signUpFormKey,
                  child: Column(
                    children: [
                      text(text: 'User Name'),
                      tools.buildTextField(
                        hintText: '',
                        isobsecure: false,
                        labelText: '',
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
                      text(text: 'SurName  (optional)'),
                      tools.buildTextField(
                        hintText: '',
                        isobsecure: false,
                        labelText: '',
                        controller: surnameController,
                        textInputType: TextInputType.name,
                        validator: (value) {
                          return null;
                        },
                        hint: '',
                      ),
                      SizedBox(height: 0.001 * size.height),
                      text(text: 'City'),
                      GeneralDropDownButton(
                          selectedItem: selectedCity,
                          itemsList: citysList,
                          valueChanged: ((value) {
                            setState(() {
                              selectedCity = value;
                            });
                          })),
                      SizedBox(height: 0.03 * size.height),
                      text(text: 'Gender'),
                      GeneralDropDownButton(
                          selectedItem: selectedGender,
                          itemsList: gender,
                          valueChanged: ((value) {
                            setState(() {
                              selectedGender = value;
                            });
                          })),
                      SizedBox(height: 0.05 * size.height),
                      text(text: 'Birhtdate'),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                datePicker(
                                    items: n.days,
                                    sizeWidth: size.width,
                                    valueChanged: (value) {
                                      setState(() {
                                        selectedDay = value;
                                      });
                                    }),
                                Text('Day',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            Column(
                              children: [
                                datePicker(
                                    items: n.months,
                                    sizeWidth: size.width,
                                    valueChanged: (value) {
                                      setState(() {
                                        selectedMonth = value;
                                      });
                                    }),
                                Text('Month',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            Column(
                              children: [
                                datePicker(
                                    items: n.years,
                                    sizeWidth: size.width,
                                    valueChanged: (value) {
                                      setState(() {
                                        selectedYear = value;
                                      });
                                    }),
                                Text('Year',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.001 * size.height),
                tools.buildButton(
                  onPressed: () async {
                    bool isvalid = signUpFormKey.currentState!.validate();
                    if (isvalid) {
                      DateTime now = DateTime.now();
                      final formatter = DateFormat('yyyy-MM-dd');
                      final String formatted = formatter.format(now);
                      BirthDateModel birthDate = BirthDateModel(
                          year: int.parse(selectedYear),
                          day: int.parse(selectedDay),
                          month: int.parse(selectedMonth));
                      FireStoreService().addUserToDBWithInformationUsers(
                          userModel: UserModelReady(
                        tacherOrStudent: 'Student',
                        name: userNameController!.text,
                        createdAt: formatted,
                        birthDate: birthDate.toMap(),
                        currentCity: selectedCity,
                        uid: auth.currentUser!.uid,
                        phoneNumber: auth.currentUser!.phoneNumber,
                        surname: surnameController!.text.trim(),
                        languages: [''],
                        gender: selectedGender,
                      ));
                      userNameController!.clear();
                    } else {
                      Get.snackbar('Error', 'Please Enter missing information',
                          backgroundColor: Colors.white);
                    }
                  },
                  color: orangeL,
                  child: const Text('Sign Up'),
                  widthP: 0.1 * size.width,
                  heightP: 0.1 * size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text({required String text, double? size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size ?? 18,
          ),
        ),
      ),
    );
  }

  Widget datePicker(
      {required List<String> items,
      required double sizeWidth,
      required ValueChanged<String> valueChanged}) {
    return Container(
        margin: const EdgeInsets.all(8),
        width: 0.2 * sizeWidth,
        child: DropdownButtonFormField<String>(
          value: items.first,
          items: items
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )))
              .toList(),
          onChanged: ((value) {
            valueChanged(value!);
          }),
        ));
  }
}
