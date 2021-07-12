import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:zero_day_shield/screens/failed_screen.dart';
import 'package:zero_day_shield/screens/glossery_screen.dart';
import 'package:zero_day_shield/screens/password_vault_screen.dart';
import 'package:zero_day_shield/widget/authentication.dart';
import 'encryption_screen.dart';
import 'generator_screen.dart';
import 'home_tab_screen.dart';
import 'news_screen.dart';
import 'security_tests_screen.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/home";
  static Widget current = HomeTabScreen();
  int homeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: homeIndex,
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
        onTap: (int index) async {
          if (index == 0) {
            current = HomeTabScreen();
            return;
          }
          if (index == 1) {
            current = GeneratorScreen();
            return;
          }
          if (index == 2) {
            current = FailedScreen("Authenticating");
            bool isAuthenticated =
                await Authentication.authenticateWithBiometrics();
            if (true) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (ctx) => PasswordVaultScreen()));
            }
          }
          if (index == 3) {
            current = EncryptionScreen();
            return;
          }
          if (index == 4) {
            current = SecurityTestsScreen();
            return;
          }
          if (index == 5) {
            current = NewsScreen();
            return;
          }
          if (index == 6) {
            current = GlosseryScreen();
            return;
          }
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
