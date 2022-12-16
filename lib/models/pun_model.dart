import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'pun_model.g.dart';

@HiveType(typeId: 2)
class PunModel extends HiveObject {
  @HiveField(0)
  String punishment;

  @HiveField(1)
  String id;
  PunModel({
    required this.punishment,
  }) : id = const Uuid().v4();
}
