import 'dart:async';
import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/customs/custom_container.dart';
import 'package:challange_app/models/chall_model.dart';
import 'package:challange_app/models/player_model.dart';
import 'package:challange_app/models/pun_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.player,
    this.index,
  });
  final Player player;
  final int? index;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final StreamController<int> selected = StreamController<int>();
  final StreamController<int> selected2 = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var punList = context.watch<PlayerProvider>().puns;
    var chaList = context.watch<PlayerProvider>().challs;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          leading: _chevronLeft(context),
          title: _title(context),
        ),
        floatingActionButton: Row(
          children: [
            WidgetFunctions.addHorizontalSpace(size.width / 9),
            _buttonMinusTwo(context),
            WidgetFunctions.addHorizontalSpace(size.width / 10),
            _buttonZero(context),
            WidgetFunctions.addHorizontalSpace(size.width / 10),
            _buttonPlusOne(context),
            WidgetFunctions.addHorizontalSpace(size.width / 10),
            _buttonPlusTwo(context),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              WidgetFunctions.addVerticalSpace(size.height / 20),
              _doRow(context),
              WidgetFunctions.addVerticalSpace(size.height / 50),
              _challengeRoll(chaList),
              WidgetFunctions.addVerticalSpace(size.height / 6),
              _ifYouFail(context),
              WidgetFunctions.addVerticalSpace(size.height / 50),
              _punishRoll(punList),
              WidgetFunctions.addVerticalSpace(size.height / 25),
              _rollButton(chaList, punList),
            ],
          ),
        ),
      ),
    );
  }

  Column _title(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.player.nickName} it\'s your turn !',
          style: GoogleFonts.bebasNeue(fontSize: 30, color: colorBlack),
        ),
        Text(
          'Point : ${widget.player.point}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }

  GestureDetector _chevronLeft(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.chevron_left,
        color: colorBlack,
      ),
    );
  }

  FloatingActionButton _buttonZero(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: colorWhite,
      heroTag: '0',
      onPressed: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Almost!!'),
          ),
        );
      },
      child: Center(
        child: Text(
          '0',
          style: GoogleFonts.dosis(
              fontWeight: FontWeight.bold, color: colorBlack, fontSize: 18),
        ),
      ),
    );
  }

  FloatingActionButton _buttonPlusOne(BuildContext context) {
    return FloatingActionButton(
      heroTag: '+1',
      onPressed: () {
        context.read<PlayerProvider>().plusOne(widget.index ?? 0);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Congratulations, you got +1 Point !',
            ),
          ),
        );
      },
      backgroundColor: colorLightGreen,
      child: Text(
        '+1',
        style: GoogleFonts.dosis(fontWeight: FontWeight.bold),
      ),
    );
  }

  FloatingActionButton _buttonPlusTwo(BuildContext context) {
    return FloatingActionButton(
      heroTag: '+2',
      backgroundColor: colorGreen,
      onPressed: () {
        context.read<PlayerProvider>().plusTwo(widget.index ?? 0);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Impressive, you got +2 Points!'),
          ),
        );
      },
      child: Text(
        '+2',
        style: GoogleFonts.dosis(fontWeight: FontWeight.bold),
      ),
    );
  }

  FloatingActionButton _buttonMinusTwo(BuildContext context) {
    return FloatingActionButton(
      heroTag: '-2',
      backgroundColor: colorRed,
      onPressed: () {
        context.read<PlayerProvider>().minusTwo(widget.index ?? 0);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nice try, you lost -2 Points !'),
          ),
        );
      },
      child: Text(
        '-2',
        style: GoogleFonts.dosis(fontWeight: FontWeight.bold),
      ),
    );
  }

  CustomContainer _rollButton(Box<ChallModel> chaList, Box<PunModel> punList) {
    return CustomContainer(
      color: Colors.black87.withOpacity(0.9),
      onTap: () async {
        final player = AudioPlayer();
        await player.setAsset('assets/spinning_wheel.mp3');
        player.play();
        setState(() {
          selected.add(
            Fortune.randomInt(0, chaList.length),
          );
          selected2.add(
            Fortune.randomInt(0, punList.length),
          );
        });
      },
      child: const Text(
        'Roll',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  FortuneBar _punishRoll(Box<PunModel> punList) {
    return FortuneBar(
      styleStrategy: const AlternatingStyleStrategy(),
      animateFirst: false,
      selected: selected2.stream,
      items: [
        for (var puns in punList.values)
          FortuneItem(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(puns.punishment),
            ),
          ),
      ],
    );
  }

  Row _ifYouFail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Penalty',
          style: Theme.of(context).textTheme.headline6,
        ),
        WidgetFunctions.addHorizontalSpace(5),
        Image.asset(
          'assets/scalesblack.png',
          height: 30,
        ),
      ],
    );
  }

  FortuneBar _challengeRoll(Box<ChallModel> chaList) {
    return FortuneBar(
      styleStrategy: const AlternatingStyleStrategy(),
      animateFirst: false,
      selected: selected.stream,
      items: [
        for (var challs in chaList.values)
          FortuneItem(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(challs.challenge),
            ),
          ),
      ],
    );
  }

  Row _doRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Challenge',
          style: Theme.of(context).textTheme.headline6,
        ),
        WidgetFunctions.addHorizontalSpace(5),
        Image.asset(
          'assets/biceps1black.png',
          height: 30,
        ),
      ],
    );
  }
}
