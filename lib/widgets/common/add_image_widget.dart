import 'package:flutter/material.dart';

class AddImageWidget extends StatelessWidget {
  AddImageWidget({
    super.key,
    required this.backgroundImage,
    required this.onTap,
  });

  ImageProvider<Object>? backgroundImage;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: backgroundImage,
        ),
        InkWell(
          onTap: onTap,
          child: const CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
              size: 15,
            ),
          ),
        )
      ],
    );
  }
}
