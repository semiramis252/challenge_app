import 'package:hive_flutter/hive_flutter.dart';
part 'player_model.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject {
  @HiveField(0)
  String nickName;

  @HiveField(1)
  int point;
  Player({
    required this.nickName,
    required this.point,
  });
}
