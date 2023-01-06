import 'package:challange_app/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StateManagement on BuildContext {
  PlayerProvider player({bool listen = false}) {
    return Provider.of<PlayerProvider>(this, listen: listen);
  }
}
