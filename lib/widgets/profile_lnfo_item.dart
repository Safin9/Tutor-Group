import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.desc,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Row(children: <Widget>[
          Text('${title.toUpperCase()} :',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(desc, style: const TextStyle(fontSize: 14))
        ]),
      ),
    );
  }
}
