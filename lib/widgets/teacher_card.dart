import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/utils/constant.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({Key? key, required this.user}) : super(key: key);
  final UserModelReady user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String? userImage;
// this is the format of getting image by url
    if (user.imageUrl != null || user.imageUrl!.isNotEmpty) {
      final String image = user.imageUrl!.replaceAll("/", "%2F");
      userImage =
          'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
    } else {
      userImage = null;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * size.width, vertical: 0.04 * size.height),
      child: BlurryContainer(
          blur: 5,
          height: 0.4 * size.height,
          width: 0.6 * size.width,
          color: Get.isDarkMode
              ? Colors.grey.withOpacity(0.11)
              : Colors.white.withOpacity(0.11),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: 0.4 * size.height,
                  decoration: BoxDecoration(
                      gradient: Get.isDarkMode
                          ? const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 19, 88, 145),
                                Colors.transparent,
                              ],
                            )
                          : const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                  Color.fromARGB(255, 171, 200, 224),
                                  Colors.transparent,
                                ]),
                      color: Get.isDarkMode
                          ? kDarkPrimaryColor
                          : kLightPrimaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (user.imageUrl!.isEmpty || user.imageUrl == null)
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 0.15 * size.width,
                              backgroundImage: const AssetImage(
                                  'assets/images/tutorlogo.png'),
                            ),
                          )
                        else
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 0.15 * size.width,
                              backgroundImage:
                                  CachedNetworkImageProvider(userImage!),
                            ),
                          ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        nameTitle(name: user.name, surName: user.surname)
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        cardItem(
                            title: 'Subject:',
                            info: user.lessonType ?? '',
                            sizeWidth: size.width),
                        if (user.lessonType == 'Biology')
                          subjectPic(name: 'biology', sizeWidth: size.width)
                        else if (user.lessonType == 'Mathematics')
                          subjectPic(name: 'maths', sizeWidth: size.width)
                        else if (user.lessonType == 'Chemistry')
                          subjectPic(name: 'chemistry', sizeWidth: size.width)
                        else if (user.lessonType == 'Arabic')
                          subjectPic(name: 'arabic', sizeWidth: size.width)
                        else if (user.lessonType == 'Physics')
                          subjectPic(name: 'physics', sizeWidth: size.width)
                        else if (user.lessonType == 'Kurdish')
                          subjectPic(name: 'kurdish', sizeWidth: size.width)
                        else if (user.lessonType == 'English')
                          subjectPic(name: 'english', sizeWidth: size.width)
                        else
                          Container(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget subjectPic({required String name, required double sizeWidth}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 0.2 * sizeWidth,
        height: 0.2 * sizeWidth,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/$name.jpg')),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
      ),
    );
  }

  Widget nameTitle({required String name, required String surName}) {
    return Expanded(
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectableText(
                surName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardItem(
      {required String title,
      required String info,
      required double sizeWidth}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: Wrap(
          children: [
            SelectableText(
              title,
              style: TextStyle(
                  fontSize: 0.04 * sizeWidth, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 0.06 * sizeWidth,
            ),
            SelectableText(
              info,
              style: TextStyle(
                  fontSize: 0.045 * sizeWidth, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
