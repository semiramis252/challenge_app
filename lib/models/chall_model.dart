import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'chall_model.g.dart';

@HiveType(typeId: 1)
class ChallModel extends HiveObject {
  @HiveField(0)
  String challenge;

  @HiveField(1)
  String id;
  ChallModel({
    required this.challenge,
  }) : id = const Uuid().v4();
}
