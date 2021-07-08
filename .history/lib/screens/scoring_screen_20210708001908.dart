import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'generator_screen.dart';
import 'package:password_compromised/password_compromised.dart';
import 'dart:core';
import '../values/values.dart';

class ScoringScreen extends StatefulWidget {
  static const routeName = "/encryption-screen";
  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  TextEditingController _passwordWork = new TextEditingController();
  Widget _result;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Password Tester",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(child: Image.asset(ImagePath.scoreImage)),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
