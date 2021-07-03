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
  //TextEditingController _emailWork = new TextEditingController();
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  "Password Checker",
                                  style: TextStyle(fontSize: 30),
                                  softWrap: true,
                                )),
                                FlatButton(
                                  child: Text("Paste",style:TextStyle(color:Colors.blue)),
                                  onPressed: () async{
                                    _passwordWork.text =
                                        await FlutterClipboard.paste();
                                  },
                                ),
                              ],
                            ),
                            TextField(
                              maxLength: 50,
                              decoration: InputDecoration(
                                  labelText: 'Enter a password'),
                              controller: _passwordWork,
                              onSubmitted: (value) {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.lightBlue[900],
                  child: Text("Calculate"),
                  onPressed: () async {
                    if (_passwordWork.text.length > 0) {
                      double strength =
                          estimatePasswordStrength(_passwordWork.text);
                      bool isComp =
                          await isPasswordCompromised(_passwordWork.text);
                      setState(() {
                        _showResult = true;
                        _result = Container(
                          margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(text: "Your password is "),
                                        isComp
                                            ? TextSpan(
                                                text: "COMPROMISED",
                                                style: TextStyle(
                                                    color: Colors.red))
                                            : TextSpan(text: "NOT compromised"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Password Score"),
                                  SizedBox(
                                    child: Image.asset(
                                      "assets/images/star${strength > .92 ? "5" : strength > .7 ? "4" : strength > .45 ? "3" : strength > .2 ? "2" : "1"}.png",
                                      scale: 1.5,
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        new GeneratorScreen()));
                                          },
                                          child: const Text(
                                              "Generate New Password",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ))),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ),
                        );
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                _showResult ? _result : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
