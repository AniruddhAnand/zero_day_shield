import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'encryption_screen.dart';
import 'generator_screen.dart';
import 'home_tab_screen.dart';
import 'news_screen.dart';
import 'security_tests_screen.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _current = HomeTabScreen();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Color.fromRGBO(66, 123, 173, 68),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house)),
          BottomNavigationBarItem(icon: Icon(Icons.vpn_key)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lock)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.news)),
        ],
        onTap: (int index) {
          if (index == 0) {
            setState(() {
              _current = new HomeTabScreen();
            });
          }
          if (index == 1) {
            setState(() {
              _current = new GeneratorScreen();
            });
            _current = new GeneratorScreen();
          }
          if (index == 2) {
            setState(() {
              _current = new EncryptionScreen();
            });
          }
          if (index == 3) {
            setState(() {
              _current = new SecurityTestsScreen();
            });
          }
          if (index == 4) {
            setState(() {
              _current = new NewsScreen();
            });
          }
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _current;
          },
        );
      },
    );
  }
}
