import 'package:flutter/material.dart';
import 'package:gamepay/utils/players.dart';
import 'package:provider/provider.dart';
import 'button.dart';
import 'labelledInput.dart';
import 'nfcReader.dart';

class AddPlayer extends StatefulWidget {
  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _amount;
  final _cardId = TextEditingController();

  Future<void> openDialog(PlayersBloc playersBloc) async {
    _cardId.text = "";

    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              backgroundColor: Color(0xFF2D3748),
              contentPadding: EdgeInsets.all(25.0),
              children: <Widget>[
                Container(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            LabelledInput(
                              labelText: "Name",
                              validator: (String value) => value.isEmpty
                                  ? 'Name of the player is required'
                                  : null,
                              onSaved: (String value) {
                                _name = value;
                              },
                            ),
                            SizedBox(height: 15),
                            LabelledInput(
                                labelText: "Initial Amount",
                                keyboardType: TextInputType.number,
                                validator: (String value) => value.isEmpty
                                    ? "Starting amount is required"
                                    : null,
                                onSaved: (String value) {
                                  _amount = int.parse(value);
                                }),
                            SizedBox(height: 15),
                            LabelledInput(
                                labelText: "Card",
                                hintText: "Bring RFID card near NFC sensor",
                                disabled: true,
                                controller: _cardId,
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return "A card must be specified";

                                  if (playersBloc.player(value) != null)
                                    return "Player already exists, try new card";
                                  
                                  return null;
                                }),
                            NFCReader(onMessage: (message) {
                              _cardId.text = message.id;
                            }),
                            SizedBox(height: 30),
                            SolidButton(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  playersBloc.addPlayer(
                                      _cardId.text, _name, _amount);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Add Player"),
                            )
                          ]),
                    ))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final PlayersBloc playersBloc = Provider.of<PlayersBloc>(context);

    return SizedBox(
      width: double.infinity,
      child: Button(
        child: Text("Add Player"),
        onTap: () => openDialog(playersBloc),
      ),
    );
  }
}
