import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/screens/home/setting_page.dart';
import 'package:tutor_group/widgets/profile_header.dart';
import 'package:tutor_group/widgets/profile_information.dart';
import 'package:tutor_group/widgets/profile_lnfo_item.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final UserModelReady user =
        Provider.of<UserProvider>(context, listen: false).theUser!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile'), actions: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              Get.to(
                () => const Settingsr(),
                transition: Transition.cupertino,
              );
            },
            icon: const Icon(
              Icons.settings,
              size: 25,
            ),
          ),
        ]),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const ProfileHeader(),
                    SizedBox(height: 0.025 * size.height),
                    Wrap(
                      children: [
                        user.tacherOrStudent! == 'Teacher'
                            ? user.shortbio != null
                                ? SelectableText(
                                    user.shortbio.toString(),
                                    style: bioStyle(),
                                  )
                                : Container()
                            : Container()
                      ],
                    ),
                    SizedBox(height: 0.025 * size.height),
                    user.tacherOrStudent! == 'Teacher'
                        ? const ProfileInformation()
                        : Container(
                            child: Column(
                              children: [
                                ProfileListItem(
                                    icon: Icons.abc,
                                    title: 'Full Name',
                                    desc: user.name),
                                ProfileListItem(
                                    icon: Icons.abc,
                                    title: 'Joined tutor at',
                                    desc: user.createdAt),
                                ProfileListItem(
                                    icon: Icons.abc,
                                    title: 'Phone Number',
                                    desc: user.phoneNumber!),
                              ],
                            ),
                          ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle bioStyle() {
    return const TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  }
}
