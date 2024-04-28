import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.24,
      width: context.width * 0.5,
      child: AlertDialog(
        title: Text(title),
        content: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok')),
      ),
    );
  }
}
