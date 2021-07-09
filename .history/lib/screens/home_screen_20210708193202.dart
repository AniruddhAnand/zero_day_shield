import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:zero_day_shield/screens/glossery_screen.dart';
import 'encryption_screen.dart';
import 'generator_screen.dart';
import 'home_tab_screen.dart';
import 'news_screen.dart';
import 'security_tests_screen.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/home";
  static Widget current = HomeTabScreen();
  static void changeCurrent(int index) {
    if (index == 0) {
      current = HomeTabScreen();
    }
    if (index == 1) {
      current = GeneratorScreen();
    }
    if(index == 2){
      
    }
    if (index == 3) {
      current = EncryptionScreen();
    }
    if (index == 4) {
      current = SecurityTestsScreen();
    }
    if (index == 5) {
      current = NewsScreen();
    }
    if (index == 6) {
      current = GlosseryScreen();
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
          BottomNavigationBarItem(icon: Icon(Icons.list_rounded)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lock)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.news)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.book)),
        ],
        onTap: (int index) {
          changeCurrent(index);
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return current;
          },
        );
      },
    );
  }
}
