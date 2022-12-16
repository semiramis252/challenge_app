import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/customs/custom_textfield.dart';
import 'package:challange_app/customs/player_row.dart';
import 'package:challange_app/models/player_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ChoosePlayer extends StatefulWidget {
  const ChoosePlayer({super.key});

  @override
  State<ChoosePlayer> createState() => _ChoosePlayerState();
}

class _ChoosePlayerState extends State<ChoosePlayer> {
  final TextEditingController playerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final playerList = context.watch<PlayerProvider>().player;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          children: [
            WidgetFunctions.addHorizontalSpace(size.width / 7),
            _addPlayerButton(context),
            WidgetFunctions.addHorizontalSpace(size.width / 20),
            _refrestPointsButton(),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              WidgetFunctions.addVerticalSpace(size.height / 25),
              Row(
                children: [
                  _chevronLeft(),
                  WidgetFunctions.addHorizontalSpace(
                    size.width / 10,
                  ),
                  _title(context),
                ],
              ),
              WidgetFunctions.addVerticalSpace(size.height / 30),
              playerList.values.isEmpty
                  ? const Text(
                      'Your players will appear here ',
                    )
                  : _playerListView(playerList),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _playerListView(Box<Player> playerList) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: playerList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: PlayerRow(
            player: playerList.values.elementAt(index),
            index: index,
          ),
        ),
      ),
    );
  }

  Padding _chevronLeft() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.chevron_left,
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      'Choose a player to roll',
      style: Theme.of(context).textTheme.headline6?.copyWith(
            color: colorBlack,
          ),
    );
  }

  FloatingActionButton _refrestPointsButton() {
    return FloatingActionButton.extended(
      label: Row(
        children: [
          Text(
            'Refresh Points',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: colorWhite),
          ),
          WidgetFunctions.addHorizontalSpace(5),
          const Icon(
            Icons.refresh_rounded,
            color: colorWhite,
          ),
        ],
      ),
      heroTag: 'buttonPlay',
      backgroundColor: colorBlack,
      onPressed: () {
        context.read<PlayerProvider>().clearPoints();
      },
    );
  }

  FloatingActionButton _addPlayerButton(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'buttonAddPlayer',
      backgroundColor: colorBlack,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            backgroundColor: Colors.white,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: playerController,
                  labelText: 'Player Name',
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (playerController.text.isNotEmpty) {
                    final player =
                        Player(nickName: playerController.text, point: 0);
                    playerController.clear();
                    context.read<PlayerProvider>().addPlayer(player);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fill the blanks!',
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    color: colorLightRed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      label: Row(
        children: [
          Text(
            'Add Player',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: colorWhite),
          ),
          WidgetFunctions.addHorizontalSpace(5),
          const Icon(
            Icons.add,
            color: colorWhite,
          ),
        ],
      ),
    );
  }
}
