import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/models/player_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:challange_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerRow extends StatefulWidget {
  const PlayerRow({
    super.key,
    required this.player,
    this.backgroundColor,
    this.playColor,
    this.editcolor,
    this.shadowColor,
    this.index,
  });
  final Player player;
  final Color? backgroundColor, playColor, editcolor, shadowColor;
  final int? index;

  @override
  State<PlayerRow> createState() => _PlayerRowState();
}

class _PlayerRowState extends State<PlayerRow> {
  final TextEditingController playerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: _padding(),
      margin: _margin(),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          _playButton(context, widget.index ?? 0),
          WidgetFunctions.addHorizontalSpace(size.width / 50),
          _nickNameAndPoints(context),
          const Spacer(),
          _editAndDelete(context),
        ],
      ),
    );
  }

  Column _nickNameAndPoints(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.player.nickName,
          style: Theme.of(context).textTheme.headline6,
        ),
        WidgetFunctions.addVerticalSpace(5),
        Text(
          'Point : ${widget.player.point}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: widget.shadowColor ?? Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(12),
      color: widget.backgroundColor ?? colorLightGrey,
    );
  }

  EdgeInsets _margin() => const EdgeInsets.only(bottom: 10);

  EdgeInsets _padding() {
    return const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 20,
    );
  }

  GestureDetector _playButton(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(player: widget.player, index: index),
          ),
        );
      },
      child: Icon(
        Icons.play_arrow_rounded,
        color: widget.playColor ?? colorBlack,
      ),
    );
  }

  Row _editAndDelete(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: colorBlack,
                      controller: playerController,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: colorBlack,
                        ),
                        filled: true,
                        fillColor: colorLightGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintText: widget.player.nickName,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (playerController.text.isNotEmpty) {
                        context
                            .read<PlayerProvider>()
                            .updatePlayer(widget.player, playerController.text);
                        playerController.clear();
                        Navigator.of(context).pop();
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
                          'Update',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
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
          child: Icon(
            Icons.edit,
            color: widget.editcolor ?? colorLightGreen,
          ),
        ),
        WidgetFunctions.addHorizontalSpace(15),
        GestureDetector(
          onTap: () {
            context.read<PlayerProvider>().removePlayer(widget.player);
          },
          child: const Icon(
            Icons.delete_rounded,
            color: colorLightRed,
          ),
        ),
      ],
    );
  }
}
