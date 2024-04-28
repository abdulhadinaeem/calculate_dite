import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.title, required this.onPressed});
  Widget title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 50,
        color: Colors.purple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        minWidth: double.infinity,
        onPressed: onPressed,
        child: title);
  }
}
