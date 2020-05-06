import 'package:flutter/material.dart';
import 'package:gamepay/utils/player.dart';
import 'package:gamepay/utils/players.dart';
import 'package:gamepay/widgets/button.dart';
import 'package:gamepay/widgets/labelledInput.dart';
import 'package:provider/provider.dart';

class MegaChoice extends StatelessWidget {
  final Color color;
  final Widget child;
  final bool isSelected;
  final void Function() onTap;

  MegaChoice(
      {this.onTap,
      this.child,
      this.color = Colors.lightBlueAccent,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      textStyle: TextStyle(color: color, fontFamily: 'Poppins', fontSize: 16),
      color: Color(0xFF2D3748),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class Transact extends StatefulWidget {
  @override
  _TransactState createState() => _TransactState();
}

class _TransactState extends State<Transact> {
  final _formKey = GlobalKey<FormState>();
  PaymentMode _mode;
  String _opponentId;
  int _amount;

  @override
  void initState() {
    super.initState();
    _mode = PaymentMode.Collect;
    _opponentId = '0';
  }

  void transact(PlayersBloc playersBloc, String cardId) {
    final activePlayer = playersBloc.player(cardId);
    final receiver = playersBloc.player(_opponentId);
    final opponentId = _opponentId == "0" ? "Bank" : _opponentId;

    if (_mode == PaymentMode.Collect) {
      activePlayer.collect(_amount, opponentId);
      if (receiver != null) {
        receiver.pay(_amount, cardId);
      }
    } else if (_mode == PaymentMode.Pay) {
      activePlayer.pay(_amount, opponentId);
      if (receiver != null) {
        receiver.collect(_amount, cardId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final PlayersBloc playersBloc = Provider.of<PlayersBloc>(context);
    final String cardId = ModalRoute.of(context).settings.arguments;
    final Player player = playersBloc.player(cardId);

    return Scaffold(
      body: Center(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 100),
                SizedBox(
                  height: 85,
                  child: GridView.count(
                    padding: EdgeInsets.all(5),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    primary: false,
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                    children: <Widget>[
                      MegaChoice(
                        child: Text("Collect"),
                        color: Colors.green,
                        isSelected: _mode == PaymentMode.Collect,
                        onTap: () {
                          setState(() {
                            _mode = PaymentMode.Collect;
                          });
                        },
                      ),
                      MegaChoice(
                          child: Text("Pay"),
                          color: Colors.red[600],
                          isSelected: _mode == PaymentMode.Pay,
                          onTap: () {
                            setState(() {
                              _mode = PaymentMode.Pay;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: LabelledInput(
                    labelText: "Amount",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) return "Amount is required";
                      if (int.parse(value) <= 0)
                        return "Amount should be positive";

                      return null;
                    },
                    onSaved: (value) {
                      _amount = int.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 45),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.all(5),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    childAspectRatio: 2.2,
                    primary: false,
                    children: <Widget>[
                      MegaChoice(
                        child: Text("Bank"),
                        isSelected: _opponentId == '0',
                        onTap: () {
                          setState(() {
                            _opponentId = '0';
                          });
                        },
                      ),
                      ...playersBloc.players
                          .where((player) => player.cardId != cardId)
                          .map((player) => MegaChoice(
                                child: Text(player.name),
                                isSelected: _opponentId == player.cardId,
                                onTap: () {
                                  setState(() {
                                    _opponentId = player.cardId;
                                  });
                                },
                              ))
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 300,
        height: 55,
        margin: EdgeInsets.only(bottom: 15),
        child: SolidButton(
          onTap: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              transact(playersBloc, cardId);
              Navigator.pop(context);
            }
          },
          child: Text(_mode == PaymentMode.Pay ? "Pay" : "Collect"),
          color: _mode == PaymentMode.Pay ? Colors.red[600] : Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
