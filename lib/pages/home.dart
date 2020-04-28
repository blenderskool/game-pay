import 'package:flutter/material.dart';
import 'package:gamepay/utils/players.dart';
import 'package:gamepay/widgets/button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
            child: Material(
          textStyle: TextStyle(color: Colors.white, fontSize: 17.0),
          color: Color(0xFF2D3748),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          elevation: 12.0,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Players(),
          ),
        )),
      ),
      floatingActionButton: Container(
        width: 300,
        height: 55,
        margin: EdgeInsets.only(bottom: 15),
        child: SolidButton(
          onTap: () {
            Navigator.pushNamed(context, '/game');
          },
          child: Text("Start Game"),
          // disabled: playersBloc.players.length < 2,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
