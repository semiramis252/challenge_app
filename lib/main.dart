import 'package:challange_app/consts/colors.dart';
import 'package:challange_app/models/chall_model.dart';
import 'package:challange_app/models/player_model.dart';
import 'package:challange_app/models/pun_model.dart';
import 'package:challange_app/provider/player_provider.dart';
import 'package:challange_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box playerBox;
late Box challBox;
late Box punBox;
void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Player>(PlayerAdapter());
  Hive.registerAdapter<ChallModel>(ChallModelAdapter());
  Hive.registerAdapter<PunModel>(PunModelAdapter());

  challBox = await Hive.openBox<ChallModel>('challs');
  punBox = await Hive.openBox<PunModel>('puns');
  playerBox = await Hive.openBox<Player>('players');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayerProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: colorLightGrey,
          primarySwatch: colorPrimary,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        home: const HomePage(),
      ),
    );
  }
}
