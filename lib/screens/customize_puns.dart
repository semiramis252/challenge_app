import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/consts/widget_functions.dart';
import 'package:challange_app/customs/custom_container.dart';
import 'package:challange_app/customs/custom_textfield.dart';
import 'package:challange_app/models/pun_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CustomizePuns extends StatefulWidget {
  const CustomizePuns({super.key});

  @override
  State<CustomizePuns> createState() => _CustomizePunsState();
}

class _CustomizePunsState extends State<CustomizePuns> {
  final TextEditingController punController = TextEditingController();

  @override
  void dispose() {
    punController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var punList = context.watch<PlayerProvider>().puns;
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
                    _defaultButton(punList, context),
                  ],
                ),
              ),
              WidgetFunctions.addVerticalSpace(size.height / 35),
              punList.isNotEmpty
                  ? _punListView(punList)
                  : const Text('Your penalties will appear here !'),
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
        'Add Penalty',
        style: TextStyle(color: colorWhite),
      ),
    );
  }

  Expanded _punListView(Box<PunModel> punList) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: punList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: CustomContainer(
            color: colorLightWhite,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(punList.values.elementAt(index).punishment),
                GestureDetector(
                  onTap: () {
                    context.read<PlayerProvider>().deletePun(
                          punList.values.elementAt(index).id,
                        );
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

  GestureDetector _defaultButton(Box<PunModel> punList, BuildContext context) {
    return GestureDetector(
      onTap: () {
        for (var e in punList.values) {
          context.read<PlayerProvider>().deletePun(e.id);
        }
        context.read<PlayerProvider>().defaultPuns();
      },
      child: const Icon(
        Icons.refresh_rounded,
      ),
    );
  }

  Text _centerTitle(BuildContext context) {
    return Text(
      'Create your own penalty set',
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
              controller: punController,
              labelText: 'Penalty',
            ),
          ),
          GestureDetector(
            onTap: () {
              if (punController.text.isNotEmpty) {
                punController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please add a penalty!',
                    ),
                  ),
                );
              }
            },
            child: GestureDetector(
              onTap: () {
                final punModel = PunModel(punishment: punController.text);
                context.read<PlayerProvider>().createPun(punModel);
                punController.clear();
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
