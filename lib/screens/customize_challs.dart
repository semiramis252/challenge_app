import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/customs/custom_container.dart';
import 'package:challange_app/customs/custom_textfield.dart';
import 'package:challange_app/models/chall_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CustomizeChalls extends StatefulWidget {
  const CustomizeChalls({super.key});

  @override
  State<CustomizeChalls> createState() => _CustomizeChallsState();
}

class _CustomizeChallsState extends State<CustomizeChalls> {
  final TextEditingController challController = TextEditingController();

  @override
  void dispose() {
    challController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var chaList = context.watch<PlayerProvider>().challs;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              WidgetFunctions.addVerticalSpace(size.height / 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _chevronLeft(context),
                    _centerTitle(context),
                    _defaultButton(chaList, context),
                  ],
                ),
              ),
              WidgetFunctions.addVerticalSpace(size.height / 35),
              chaList.isNotEmpty
                  ? _listViewBuilder(chaList)
                  : const Text('Your challenges will appear here !'),
              _addButton(context),
              WidgetFunctions.addVerticalSpace(size.height / 23),
            ],
          ),
        ),
      ),
    );
  }

  CustomContainer _addButton(BuildContext context) {
    return CustomContainer(
      color: colorBlack,
      onTap: () {
        _showDialog(context);
      },
      child: const Text(
        'Add Challenge',
        style: TextStyle(color: colorWhite),
      ),
    );
  }

  Expanded _listViewBuilder(Box<ChallModel> chaList) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: chaList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: CustomContainer(
            color: colorLightGrey,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(chaList.values.elementAt(index).challenge),
                GestureDetector(
                  onTap: () {
                    context
                        .read<PlayerProvider>()
                        .deleteChall(chaList.values.elementAt(index).id);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: colorLightRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _defaultButton(
      Box<ChallModel> chaList, BuildContext context) {
    return GestureDetector(
      onTap: () {
        for (var e in chaList.values) {
          context.read<PlayerProvider>().deleteChall(e.id);
        }
        context.read<PlayerProvider>().defaultChalls();
      },
      child: const Icon(
        Icons.refresh_rounded,
      ),
    );
  }

  Text _centerTitle(BuildContext context) {
    return Text(
      'Create your own challenge set',
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  GestureDetector _chevronLeft(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.chevron_left,
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: challController,
              labelText: 'Challange',
            ),
          ),
          GestureDetector(
            onTap: () {
              if (challController.text.isNotEmpty) {
                challController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please add a challange!',
                    ),
                  ),
                );
              }
            },
            child: GestureDetector(
              onTap: () {
                final challModel = ChallModel(challenge: challController.text);
                context.read<PlayerProvider>().createChallange(challModel);
                challController.clear();
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
          ),
        ],
      ),
    );
  }
}
