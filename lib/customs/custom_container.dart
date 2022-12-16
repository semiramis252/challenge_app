import 'package:challange_app/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.color,
      required this.onTap,
      this.child,
      this.padding,
      this.shadowColor,
      this.width,
      this.height});
  final Color? color, shadowColor;
  final VoidCallback onTap;
  final Widget? child;
  final EdgeInsets? padding;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 30,
            ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: color ?? colorYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
