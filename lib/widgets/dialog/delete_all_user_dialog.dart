import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteUserDialog extends StatelessWidget {
  DeleteUserDialog({super.key, required this.title, required this.onPressed});
  String title;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.24,
      width: context.width * 0.5,
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'cancel',
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
