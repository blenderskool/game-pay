import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gamepay/utils/players.dart';
import 'package:gamepay/widgets/button.dart';
import 'package:gamepay/widgets/nfcReader.dart';
import 'package:provider/provider.dart';

class PlayerCard extends StatelessWidget {
  final String _name;
  final int _amount;

  PlayerCard(this._name, this._amount);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Color(0xFF2D3748),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
            Spacer(flex: 1),
            Text(
              _name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _amount.toString(),
              style: TextStyle(
                color: Colors.green,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlayersBloc playersBloc = Provider.of<PlayersBloc>(context);
    print(playersBloc.players);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            NFCReader(
              onMessage: (message) {
                final cardId = message.id;
                if (playersBloc.player(cardId) != null) {
                  Navigator.pushNamed(context, '/transact', arguments: cardId);
                }
              },
            ),
            DottedBorder(
              child: Container(
                  width: 300,
                  height: 200,
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: Text(
                      "Bring player card here to start a transaction",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.lightBlueAccent, fontSize: 15.0),
                    ),
                  )),
              color: Colors.lightBlueAccent,
              borderType: BorderType.RRect,
              radius: Radius.circular(4),
              dashPattern: [2, 3, 2, 3],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 52),
                primary: false,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: playersBloc.players
                    .map((player) => PlayerCard(player.name, player.amount))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 300,
        height: 55,
        margin: EdgeInsets.only(bottom: 15),
        child: Opacity(
          opacity: 0.6,
          child: Button(
            onTap: () {
              playersBloc.reset();
              Navigator.pop(context);
            },
            child: Text("End Game"),
            color: Colors.red,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
