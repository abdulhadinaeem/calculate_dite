import 'package:calculate_dite/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Function()? onPressed;

  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: context.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      content: CustomButton(
        title: Text(
          buttonTitle,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
