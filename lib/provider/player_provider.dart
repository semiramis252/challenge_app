import 'package:challange_app/models/chall_model.dart';
import 'package:challange_app/models/player_model.dart';
import 'package:challange_app/models/pun_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlayerProvider extends ChangeNotifier {
  // Player stuff ==========================================================
  final Box<Player> _player = Hive.box('players');
  Box<Player> get player => _player;

  void addPlayer(Player player) {
    _player.put(player.nickName, player);
    notifyListeners();
  }

  void removePlayer(Player player) {
    _player.delete(player.nickName);
    notifyListeners();
  }

  void updatePlayer(Player player, String string) {
    _player.delete(player.nickName);
    player.nickName = string;
    _player.put(player.nickName, player);
    notifyListeners();
  }

  void plusOne(int index) {
    _player.values.elementAt(index).point++;
    _player.values.elementAt(index).save();
    notifyListeners();
  }

  void plusTwo(int index) {
    _player.values.elementAt(index).point =
        _player.values.elementAt(index).point + 2;
    _player.values.elementAt(index).save();
    notifyListeners();
  }

  void minusOne(int index) {
    _player.values.elementAt(index).point--;
    _player.values.elementAt(index).save();
    notifyListeners();
  }

  void minusTwo(int index) {
    _player.values.elementAt(index).point =
        _player.values.elementAt(index).point - 2;
    _player.values.elementAt(index).save();
    notifyListeners();
  }

  void clearPoints() {
    for (var i in _player.values) {
      i.point = 0;
      i.save();
    }
    notifyListeners();
  }

  // Challange stuff =======================================================
  final Box<ChallModel> _challs = Hive.box('challs');
  Box<ChallModel> get challs => _challs;

  void createChallange(ChallModel challModel) {
    _challs.put(challModel.id, challModel);
    notifyListeners();
  }

  void deleteChall([key]) async {
    if (key != null) {
      await _challs.delete(key);
      notifyListeners();
      return;
    }
  }

  void defaultChalls() {
    createChallange(
      ChallModel(challenge: 'Do 40 push-ups'),
    );
    createChallange(
      ChallModel(challenge: 'Do 15 pull-ups'),
    );
    createChallange(
      ChallModel(challenge: 'Do 100 sit-ups'),
    );
    createChallange(
      ChallModel(challenge: 'Do 2 minute plank'),
    );
    createChallange(
      ChallModel(challenge: 'Do 15rep bicep curl with 15kg db'),
    );
    notifyListeners();
  }

  // Consequences stuff =======================================================
  final Box<PunModel> _puns = Hive.box<PunModel>('puns');
  Box<PunModel> get puns => _puns;

  void createPun(PunModel punModel) {
    _puns.put(punModel.id, punModel);
    notifyListeners();
  }

  void deletePun([key]) async {
    _puns.delete(key);
    notifyListeners();
  }

  void defaultPuns() {
    createPun(
      PunModel(punishment: 'Pour some water on your neck'),
    );
    createPun(
      PunModel(punishment: 'Show some dance figures'),
    );
    createPun(
      PunModel(punishment: 'Do karaoke'),
    );
    createPun(
      PunModel(punishment: 'Call a friend you haven\'t spoken recently'),
    );
    createPun(
      PunModel(punishment: 'Eat a quarter of a lemon'),
    );
    createPun(
      PunModel(punishment: 'Tell a bad moment on your life'),
    );
    createPun(
      PunModel(punishment: 'Close your eyes and turn around 10 times'),
    );
    createPun(
      PunModel(punishment: 'Make a confession'),
    );
    createPun(
      PunModel(punishment: 'Give a massage to the person on your right'),
    );
    createPun(
      PunModel(punishment: 'Say a nursery rhyme'),
    );
    notifyListeners();
  }
}
