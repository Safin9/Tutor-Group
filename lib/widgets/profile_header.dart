import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 42,
          // FIXME: add profile picture here
          // FIXME: use cachedNetworkImage instead
          backgroundImage: AssetImage('assets/images/tutorlogo.png'),
        ),
        SizedBox(width: 0.025 * size.width),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              // FIXME: add profile picture here
              'Add here the full name',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0.01 * size.height),
            const SelectableText(
              // FIXME: add profile picture here
              'add email here if exist',
              style: TextStyle(
                fontSize: 10,
                // FIXME: fontweight.w200
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
