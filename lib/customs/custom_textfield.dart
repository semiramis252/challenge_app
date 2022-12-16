import 'package:challange_app/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.fillColor,
  }) : super(key: key);

  final TextEditingController controller;
  final String? labelText, hintText;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: colorBlack,
      controller: controller,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: colorBlack,
        ),
        filled: true,
        fillColor: fillColor ?? colorLightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
