import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/birthdate_model.dart';
import 'package:tutor_group/modules/user_model.dart';

import 'package:tutor_group/screens/chats/send_message_button.dart';

class TeacherProfileDetails extends StatelessWidget {
  const TeacherProfileDetails({Key? key, required this.friendUser})
      : super(key: key);
  final UserModelReady friendUser;

  @override
  Widget build(BuildContext context) {
    String? userImage;
    if (friendUser.imageUrl != null && friendUser.imageUrl != "") {
      final String image = friendUser.imageUrl!.replaceAll("/", "%2F");
      userImage =
          'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
    } else {
      userImage = null;
    }
    List<String> langs = friendUser.languages!;
    final birthYear = BirthDateModel.fromMap(friendUser.birthDate!);
    final age = DateTime.now().year - birthYear.year;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(elevation: 15),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => <Widget>[
              SliverAppBar(
                expandedHeight: 0.5 * size.height,
                automaticallyImplyLeading: false,
                stretch: true,
                floating: false,
                elevation: 5.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: BackgroundFlexibleSpaceBar(
                    background: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: userImage != null
                            ? CachedNetworkImage(
                                imageUrl: userImage,
                                fit: BoxFit.cover,
                              )
                            : Image.asset('assets/images/tutorlogo.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent
                              ])),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ],
            body: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 0.1 * size.width, vertical: 0.03 * size.height),
              width: double.infinity,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(friendUser.name,
                              style: textStyle(sizeWidth: 1.3 * size.width)),
                          const Spacer(),
                          SendMessageButton(friendUser: friendUser),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(friendUser.surname,
                          style: textStyle(
                              sizeWidth: (0.8 * size.width),
                              color: Get.isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700])),
                      const SizedBox(height: 16),
                      Wrap(
                        children: [
                          Text(
                            friendUser.shortbio ?? '',
                            style: textStyle(
                                sizeWidth: 0.6 * size.width,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      // Text(
                      //   'jk',
                      //   style: Theme.of(context).textTheme.headline3,
                      // ),
                      const SizedBox(height: 25),
                      text(
                          title: 'Email  :',
                          desc: friendUser.email,
                          sizeWidth: size.width),
                      const SizedBox(height: 25),
                      text(
                          title: 'From  :',
                          desc: friendUser.currentCity,
                          sizeWidth: size.width),
                      const SizedBox(height: 25),
                      text(
                          title: 'Subject  :',
                          desc: friendUser.lessonType,
                          sizeWidth: size.width),
                      if (friendUser.lessonType == 'Biology')
                        subjectPic(name: 'biology', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'Mathematics')
                        subjectPic(name: 'maths', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'Chemistry')
                        subjectPic(name: 'chemistry', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'Arabic')
                        subjectPic(name: 'arabic', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'Physics')
                        subjectPic(name: 'physics', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'Kurdish')
                        subjectPic(name: 'kurdish', sizeWidth: size.width)
                      else if (friendUser.lessonType == 'English')
                        subjectPic(name: 'english', sizeWidth: size.width)
                      else
                        Container(),
                      const SizedBox(height: 25),
                      text(
                          title: 'Gender  :',
                          desc: friendUser.gender,
                          sizeWidth: size.width),
                      const SizedBox(height: 25),
                      text(
                          title: 'Languages  :',
                          desc: langs.first,
                          sizeWidth: size.width),
                      const SizedBox(height: 25),
                      text(
                          title: 'Age  :',
                          desc: '$age     years old',
                          sizeWidth: size.width),
                      const SizedBox(height: 25),
                      text(
                          title: 'Phone  :',
                          desc: friendUser.phoneNumber,
                          sizeWidth: size.width),
                      const SizedBox(height: 120),
                      Center(
                          child: Text(
                              'Joined Tutor at    ${friendUser.createdAt}'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget subjectPic({required String name, required double sizeWidth}) {
    return Container(
      width: sizeWidth,
      height: 0.5 * sizeWidth,
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/$name.jpg'), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
    );
  }

  Widget text(
      {required String title, String? desc, required double sizeWidth}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle(sizeWidth: 0.7 * sizeWidth),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  desc ?? '',
                  style: textStyle(sizeWidth: 0.7 * sizeWidth),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle textStyle({required double sizeWidth, Color? color}) {
    return TextStyle(
        fontSize: 0.055 * sizeWidth, fontWeight: FontWeight.w500, color: color);
  }
}
