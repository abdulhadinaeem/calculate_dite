import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.isImage,
    required this.isForwardIcon,
    this.icon,
  });
  Function()? onTap;
  String title;
  bool isImage;
  bool isForwardIcon;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: isImage
          ? const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
            )
          : const SizedBox(),
      trailing: isForwardIcon
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            )
          : icon,
      title: Text(title),
    );
  }
}
