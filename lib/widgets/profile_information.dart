import 'package:flutter/material.dart';
import 'package:tutor_group/widgets/profile_lnfo_item.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          ProfileListItem(icon: Icons.abc, title: 'Full Name', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'Lesson', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'City', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'Phone', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'Languages', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'Gender', desc: ''),
          ProfileListItem(icon: Icons.abc, title: 'Age', desc: ''),
        ],
      ),
    );
  }
}
