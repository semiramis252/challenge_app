import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetFunctions.addVerticalSpace(size.height / 5),
                _title1(),
                WidgetFunctions.addVerticalSpace(size.height / 23),
                _ifYouWon(context),
                WidgetFunctions.addVerticalSpace(size.height / 50),
                _won1(),
                WidgetFunctions.addVerticalSpace(size.height / 50),
                _won2(),
                WidgetFunctions.addVerticalSpace(size.height / 23),
                _ifYouLost(context),
                WidgetFunctions.addVerticalSpace(size.height / 50),
                _lost1(),
                WidgetFunctions.addVerticalSpace(size.height / 50),
                _lost2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _lost2() {
    return const Text(
      '• If you lost both of them, you will get -2 points.',
    );
  }

  Text _lost1() {
    return const Text(
      '• You already got -1 point, you have to fulfill the penalty. If you fulfill the penalty properly you will get +1 point.',
    );
  }

  Row _ifYouLost(BuildContext context) {
    return Row(
      children: [
        Text(
          'If you',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          ' lost',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold, color: colorLightRed),
        ),
        Text(
          ' the challenge :',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Text _won2() {
    return const Text(
      '• If you won both of them, you will get +2 points.',
    );
  }

  Text _won1() {
    return const Text(
      '• You already got +1 point. If you want, you can try the penalty. If you succeed, get +1 more point.',
    );
  }

  Row _ifYouWon(BuildContext context) {
    return Row(
      children: [
        Text(
          'If you',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          ' won',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold, color: colorLightGreen),
        ),
        Text(
          ' the challenge :',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Text _title1() {
    return const Text(
      '• You have to try challenge first, you can\'t skip that.',
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: _chevronLeft(context),
      elevation: 5,
      backgroundColor: colorBlack,
      centerTitle: true,
      title: const Text(
        'Rules are simple',
        style: TextStyle(color: colorWhite),
      ),
    );
  }

  GestureDetector _chevronLeft(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.chevron_left_rounded),
    );
  }
}
