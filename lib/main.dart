import 'package:flutter/material.dart';
import 'package:gamepay/utils/players.dart';
import 'package:gamepay/pages/home.dart';
import 'package:gamepay/pages/game.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PlayersBloc(),
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: Color(0xFF1A202C),
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(fontFamily: 'Poppins', bodyColor: Colors.white),
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0.0,
              )),
          routes: {
            '/': (context) => Home(),
            '/game': (context) => Game(),
          },
          initialRoute: '/',
        ));
  }
}
