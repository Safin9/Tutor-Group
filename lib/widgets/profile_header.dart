import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/modules/user_model.dart';
import 'package:tutor_group/providers/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final UserModelReady user =
        Provider.of<UserProvider>(context, listen: false).theUser!;
    String? userImage;
    if (user.imageUrl != null && user.imageUrl != "") {
      final String image = user.imageUrl!.replaceAll("/", "%2F");
      userImage =
          'https://firebasestorage.googleapis.com/v0/b/tutorgroup-9c6eb.appspot.com/o/Teachers$image?alt=media&token=1b785367-cc2f-40ad-b6de-db69536b3d92';
    } else {
      userImage = null;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (userImage == null)
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 0.15 * size.width,
              backgroundImage: const AssetImage('assets/images/tutorlogo.png'),
            ),
          )
        else
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 0.15 * size.width,
              backgroundImage: CachedNetworkImageProvider(userImage),
            ),
          ),
        SizedBox(width: 0.025 * size.width),
        Column(
          children: [
            Text(user.createdAt),
            Text(user.name),
            Text(user.surname),
            Text(user.gender),
            Text(user.tacherOrStudent!),
            // Text(user.imageUrl.toString()),
            user.lessonType != null ? Text(user.lessonType!) : Container(),
          ],
        )
      ],
    );
  }
}
