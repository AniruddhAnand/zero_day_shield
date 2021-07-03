import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/news_screen.dart';
import './screens/splash_screen.dart';
import "theme.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(255, 255, 255, .1),
    100: Color.fromRGBO(255, 255, 255, .2),
    200: Color.fromRGBO(255, 255, 255, .3),
    300: Color.fromRGBO(255, 255, 255, .4),
    400: Color.fromRGBO(255, 255, 255, .5),
    500: Color.fromRGBO(255, 255, 255, .6),
    600: Color.fromRGBO(255, 255, 255, .7),
    700: Color.fromRGBO(255, 255, 255, .8),
    800: Color.fromRGBO(255, 255, 255, .9),
    900: Color.fromRGBO(255, 255, 255, 1),
  };
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildLightTheme(context),
      home: SplashScreen(),
      routes: {
        HomeScreen.route: (ctx) => HomeScreen(),
      },
    );
  }
}
