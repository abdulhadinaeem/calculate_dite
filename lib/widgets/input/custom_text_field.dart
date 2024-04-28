import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.keyboardType,
      this.controller,
      this.initialValue,
      required this.hintText,
      required this.labelText,
      required this.validator});
  String hintText;
  String labelText;
  String? initialValue;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        initialValue: initialValue,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
