import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/screens/customize_challs.dart';
import 'package:challange_app/screens/customize_puns.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int index = 0;
  final List<Widget> screens = [
    const CustomizeChalls(),
    const CustomizePuns(),
  ];

  final items = [
    Image.asset(
      'assets/biceps1.png',
      height: 30,
    ),
    Image.asset(
      'assets/scales.png',
      height: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          height: size.height / 15,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: colorLightGrey,
          color: colorBlack,
          items: items,
          index: index,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
