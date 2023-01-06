import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/customs/custom_container.dart';
import 'package:challange_app/extensions/context_extension.dart';
import 'package:challange_app/screens/bottom_navbar.dart';
import 'package:challange_app/screens/choose_player.dart';
import 'package:challange_app/screens/rules.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _playButton(context),
        body: Center(
          child: Column(
            children: [
              WidgetFunctions.addVerticalSpace(context.dynamicHeight(0.125)),
              _contestImage(),
              WidgetFunctions.addVerticalSpace(context.cSize.height / 100),
              _helloText(),
              _subTitle1(),
              _subTitle2(),
              WidgetFunctions.addVerticalSpace(context.cSize.height / 20),
              _customizeSettingsButton(context.cSize, context),
              WidgetFunctions.addVerticalSpace(context.cSize.height / 40),
              _rulesButton(context.cSize, context),
              WidgetFunctions.addVerticalSpace(context.cSize.height / 40),
              _iconRefenceButton(context.cSize),
            ],
          ),
        ),
      ),
    );
  }

  Padding _iconRefenceButton(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: CustomContainer(
        width: size.width,
        onTap: () {},
        color: colorLightWhite,
        child: const Center(
          child: Text(
            'The icons that i use',
            style: TextStyle(color: colorBlack),
          ),
        ),
      ),
    );
  }

  Padding _rulesButton(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: CustomContainer(
        width: size.width,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Rules(),
            ),
          );
        },
        color: colorLightWhite,
        child: const Center(
          child: Text(
            'Rules',
            style: TextStyle(color: colorBlack),
          ),
        ),
      ),
    );
  }

  Padding _customizeSettingsButton(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: CustomContainer(
        width: size.width,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavbar(),
            ),
          );
        },
        color: colorLightWhite,
        child: const Center(
          child: Text(
            'Customize settings',
            style: TextStyle(color: colorBlack),
          ),
        ),
      ),
    );
  }

  Text _subTitle2() {
    return const Text(
        'You can play the game at default settings but if you wish :');
  }

  Text _subTitle1() => const Text('Are you ready for contest ?');

  Text _helloText() {
    return Text(
      'Hello !',
      style: GoogleFonts.bebasNeue(fontSize: 48),
    );
  }

  Image _contestImage() {
    return Image.asset(
      'assets/contest.png',
    );
  }

  FloatingActionButton _playButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: colorLightGrey,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChoosePlayer(),
          ),
        );
      },
      child: CircleAvatar(
        child: Image.asset(
          'assets/play1.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
