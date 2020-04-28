import 'dart:collection';
import 'package:flutter/material.dart';
import '../widgets/addPlayer.dart';
import 'package:provider/provider.dart';
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


class Players extends StatelessWidget {
  Widget _players(PlayersBloc playersBloc) {
    List<Widget> list = new List<Widget>();
    final players = playersBloc.players;

    for (int i = 0; i < players.length; i++) {
      final player = players[i];

      list.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              player.name,
              style: TextStyle(fontSize: 22.0, fontFamily: 'Poppins'),
            ),
            Spacer(flex: 1),
            Text(
              "+" + player.amount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: 'Poppins',
              ),
            )
          ],
        ),
      ));
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    final PlayersBloc playersBloc = Provider.of<PlayersBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        playersBloc.players.length > 0
            ? _players(playersBloc)
            : Text(
                "Start by adding 2 or more players",
                style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0xFF718096),
                    fontFamily: 'Poppins'),
              ),
        SizedBox(height: 30),
        AddPlayer(),
      ],
    );
  }
}