import 'dart:io';

import 'package:calculate_dite/widgets/common/custom_list_tile.dart';
import 'package:flutter/material.dart';

void showCustomModalBottomSheet(
    BuildContext context, List<CustomListTile> items) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            return ListTile(
              title: Text(item.title),
              leading: item.isImage ? Image.file(item.icon as File) : item.icon,
              onTap: () {
                item.onTap!();
              },
            );
          }).toList(),
        ),
      );
    },
  );
}
//  showModalBottomSheet(
//                     context: context,
//                     builder: (context) {
//                       return SizedBox(
//                         width: double.infinity,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CustomListTile(
//                               isForwardIcon: false,
//                               icon: const Icon(
//                                 Icons.photo,
//                                 color: Colors.black,
//                               ),
//                               onTap: () {
//                                 provider.getImageFromGallery();
//                                 Navigator.pop(context);
//                               },
//                               title: 'Gallery',
//                               isImage: false,
//                             ),
//                             CustomListTile(
//                               isForwardIcon: false,
//                               icon: const Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.black,
//                               ),
//                               onTap: () {
//                                 provider.getImageFromCamera();
//                                 Navigator.pop(context);
//                               },
//                               title: 'Camera',
//                               isImage: false,
//                             ),
//                             provider.image != null
//                                 ? CustomListTile(
//                                     isForwardIcon: false,
//                                     icon: const Icon(
//                                       Icons.clear,
//                                       color: Colors.black,
//                                     ),
//                                     onTap: () {
//                                       provider.deleteImage();
//                                       Navigator.pop(context);
//                                     },
//                                     title: 'Remove',
//                                     isImage: false,
//                                   )
//                                 : const SizedBox(),
//                           ],
//                         ),
//                       );
//                     },
//                   );