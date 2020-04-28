import 'dart:collection';
import 'package:flutter/material.dart';
import './player.dart';

class PlayersBloc extends ChangeNotifier {
  HashMap<String, Player> _players;

  PlayersBloc() {
    _players = HashMap<String, Player>();
  }

  List<Player> get players => _players.values.toList();
  int get length => _players.length;

  Player player(String cardId) {
    if (!_players.containsKey(cardId)) return null;

    return _players[cardId];
  }

  Player addPlayer(String cardId, String name, int amount) {
    final player = Player(cardId, name, amount);
    _players[cardId] = player;

    notifyListeners();
    return player;
  }

  void reset() {
    _players = HashMap<String, Player>();
  }
}