import 'package:flutter/material.dart';
import 'package:tutor_group/app%20bar%20and%20drawers/my_profile_appbar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myProfileAppBar(),
    );
  }
}
