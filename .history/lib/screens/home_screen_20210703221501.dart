import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'encryption_screen.dart';
import 'generator_screen.dart';
import 'home_tab_screen.dart';
import 'news_screen.dart';
import 'security_tests_screen.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/home";
  Widget current = HomeTabScreen();
  static void changeCurrent(int index) {
    if (index == 0) {
            _current = HomeTabScreen();
          }
          if (index == 1) {
            _current = GeneratorScreen();
          }
          if (index == 2) {
            _current = EncryptionScreen();
          }
          if (index == 3) {
            _current = SecurityTestsScreen();
          }
          if (index == 4) {
            _current = NewsScreen();
          }
  }
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
          changeCurrent(index);
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
