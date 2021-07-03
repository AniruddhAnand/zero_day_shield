import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'expanded_tile.dart';
import '../values/data.dart';
import '../values/values.dart';

class EncryptionScreen extends StatefulWidget {
  static const routeName = "/encryption-screen";
  @override
  _EncryptionScreenState createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen> {
  TextEditingController _word = new TextEditingController();

  int _subVal = 1;
  String _substituted = "";
  String _transposed = "";
  String _converted = "";
  List<Text> numbers() {
    List<Text> list = [];
    for (int i = 1; i < 27; i++) {
      list.add(Text(
        "$i",
        style: TextStyle(color: Colors.black),
      ));
    }
    return list;
  }

  void combineBin() {
    setState(() {
      _converted = _word.text.codeUnits
          .map((x) => x.toRadixString(2).padLeft(8, '0'))
          .join(" ");
    });
  }

  void transpose() {
    if (_word.text.length > 0) {
      var inputRunes = _word.text.characters.toList();
      var rng = new Random();
      for (int i = 0; i < inputRunes.length; i++) {
        int index = rng.nextInt(inputRunes.length);
        String temp = inputRunes[i];
        inputRunes[i] = inputRunes[index];
        inputRunes[index] = temp;
      }
      setState(() {
        _transposed = inputRunes.join();
      });
    }
  }

  void substitute(int rotNum) {
    List<String> outputList = [];

    var inputRunes = _word.text.runes.toList();
    for (var rune in inputRunes) {
      var mutatedRune = rune;
      if (rune != 32) {
        for (int i = 0; i < rotNum; i++) {
          mutatedRune++;
          if (mutatedRune > 90 && mutatedRune < 97) {
            mutatedRune = 65;
          }
          if (mutatedRune > 122) {
            mutatedRune = 97;
          }
        }
      }
      outputList.add(String.fromCharCode(mutatedRune));
    }

    var outputString = outputList.join("");
    setState(() {
      _substituted = outputString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(156,195,230,90),
      appBar: AppBar(
        elevation: 5.0,
        title: RichText(
          text: TextSpan(
              style: Styles.customTitleTextStyle(
                color: AppColors.headingText,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.TEXT_SIZE_22,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "Encryption ",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ExpandedTile(
                                      fullTexts[2],
                                      SizedBox(
                                        child: Image.asset(
                                          imagePaths[2],
                                        ),
                                      ),
                                      titles[2],
                                    )));
                      }),
                TextSpan(
                  text: "Demo",
                )
              ]),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextField(
                              maxLength: 30,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Enter a word',
                              ),
                              controller: _word,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Choose the number of letters to shift",
                                  style: TextStyle(
                                      color: Colors.black,
                                      // fontFamily: "monofonto",
                                      fontSize: 18),
                                ),
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 30,
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _subVal = value + 1;
                                      });
                                    },
                                    children: numbers(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  child: CupertinoButton(
                    onPressed: () {
                      transpose();
                      substitute(_subVal);
                      combineBin();
                    },
                    color: Colors.lightBlue[900],
                    child: Text(
                      "Convert",
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: "monofonto",
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Substitution:",
                              style: Styles.customTitleTextStyle(
                                color: AppColors.headingText,
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.TEXT_SIZE_22,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                _substituted,
                                textAlign: TextAlign.center,
                                style: Styles.customTitleTextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.TEXT_SIZE_22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transposition:",
                              style: Styles.customTitleTextStyle(
                                color: AppColors.headingText,
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.TEXT_SIZE_22,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                _transposed,
                                textAlign: TextAlign.center,
                                style: Styles.customTitleTextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.TEXT_SIZE_22,
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To Binary:",
                              style: Styles.customTitleTextStyle(
                                color: AppColors.headingText,
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.TEXT_SIZE_22,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                _converted,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: Styles.customTitleTextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.TEXT_SIZE_22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
                ),
                SizedBox(
                  height: 50,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                        //    fontFamily: "monofonto",
                        letterSpacing: 2),
                    children: <TextSpan>[
                      TextSpan(
                        text: "BEWARE: ",
                      ),
                      TextSpan(
                        text: "SPACES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: " COUNT AS CHARACTERS",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
