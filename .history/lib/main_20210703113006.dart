import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/news_screen.dart';
import './screens/splash_screen.dart';
import './screens/generator_screen.dart';
import "./screens/encryption_screen.dart";
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildLightTheme(context),
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: MaterialColor(0xFFFFFFFFF, color)
      // ),
      home: SplashScreen(),
      routes: {
        GeneratorScreen.routeName: (ctx) => GeneratorScreen(),
        //ScrollScreen.routeName: (ctx) => ScrollScreen(),
        EncryptionScreen.routeName: (ctx) => EncryptionScreen(),

        NewsScreen.routeName: (ctx) => NewsScreen(),
        HomeScreen.route: (ctx) => HomeScreen(),
      },
    );
  }
}
