import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EncryptionInfoScreen extends StatefulWidget {
  static const routeName = "/encryption-info-screen";
  @override
  _EncryptionInfoSceenState createState() => _EncryptionInfoSceenState();
}

class _EncryptionInfoSceenState extends State<EncryptionInfoScreen> {
  TextEditingController _substitution = new TextEditingController();
  TextEditingController _transposition = new TextEditingController();
  TextEditingController _convertion = new TextEditingController();
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

  String combineBin() {
    setState(() {
      _converted = _convertion.text.codeUnits
          .map((x) => x.toRadixString(2).padLeft(8, '0'))
          .join(" ");
    });
  }

  void transpose() {
    if (_transposition.text.length > 0) {
      var inputRunes = _transposition.text.characters.toList();
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

    var inputRunes = _substitution.text.runes.toList();
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
      //backgroundColor: Colors.brown[300],
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.deepPurple[200],
        middle: Text(
          "Encryption",
          style: TextStyle(fontFamily: "monofonto", fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: "Test",
                child: Container(
                  height: MediaQuery.of(context).size.width / 6.8 * 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue[200],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Choose the number of letters to shift",
                      style: TextStyle(fontSize: 20)),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        substitute(value + 1);
                      },
                      children: numbers(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "Substituted Text:"),
                    _substituted.length > 0
                        ? TextSpan(
                            text: _substituted, style: TextStyle(color: Colors.red))
                        : TextSpan(text: "Nothing so far"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 6.8,
                    backgroundColor: Colors.amber[100],
                    child: Text(
                      "Transposition",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "monofonto",
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Enter a word'),
                      controller: _transposition,
                      onSubmitted: (value) {
                        transpose();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "Transposed Text:"),
                    _transposed.length > 0
                        ? TextSpan(
                            text: _transposed, style: TextStyle(color: Colors.red))
                        : TextSpan(text: "Nothing so far"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 6.8,
                    backgroundColor: Colors.green[100],
                    child: Text(
                      "Convert to binary",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "monofonto",
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Enter a word'),
                      controller: _convertion,
                      onSubmitted: (value) {
                        combineBin();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: "Converted Text:"),
                    _converted.length > 0
                        ? TextSpan(
                            text: _converted, style: TextStyle(color: Colors.red))
                        : TextSpan(text: "Nothing so far"),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "BEWARE: SPACES COUNT AS CHARACTERS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
              SizedBox(
                width: 20,
              ),
              
              SizedBox(
                width: 20,
              ),
              
*/

/*return ;*/
