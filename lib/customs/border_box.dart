import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  const BorderBox({super.key, this.height, this.width, this.icon});
  final double? height, width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height ?? 50,
        width: width ?? 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}
