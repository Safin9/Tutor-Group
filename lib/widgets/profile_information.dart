import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/birthdate_model.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/widgets/profile_lnfo_item.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModelReady user =
        Provider.of<UserProvider>(context, listen: false).theUser!;
    final birthYear = BirthDateModel.fromMap(user.birthDate!);
    final age = DateTime.now().year - birthYear.year;
    return Column(
      children: [
        ProfileListItem(icon: Icons.abc, title: 'Full Name', desc: user.name),
        ProfileListItem(
            icon: Icons.abc, title: 'Lesson', desc: user.lessonType!),
        ProfileListItem(icon: Icons.abc, title: 'City', desc: user.currentCity),
        ProfileListItem(
            icon: Icons.abc, title: 'Phone', desc: user.phoneNumber!),
        ProfileListItem(icon: Icons.abc, title: 'Gender', desc: user.gender),
        ProfileListItem(icon: Icons.abc, title: 'Age', desc: age.toString()),
        ProfileListItem(
            icon: Icons.abc, title: 'Joined Tutor at', desc: user.createdAt),
      ],
    );
  }
}
