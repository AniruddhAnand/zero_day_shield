import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zero_day_shield/values/values.dart';

class RandomFactsScreen extends StatefulWidget {
  @override
  _RandomFactsScreenState createState() => _RandomFactsScreenState();
}

class _RandomFactsScreenState extends State<RandomFactsScreen> {
  int _index = 0;
  List<String> _terms = [];
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/facts.html'));
      document.getElementsByClassName("term").forEach((item) {
        setState(() {
          _terms.add(HtmlUnescape().convert(item.innerHtml));
        });
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getGlos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Cyber Security Glossary",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
          child: _terms.length == 133
              ? GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RichText(
                            softWrap: true,
                            text: TextSpan(children: [
                              TextSpan(
                                text: _terms[_index].substring(
                                    0,
                                    _terms[_index].indexOf(". (") == -1
                                        ? _terms[_index].indexOf(". ")
                                        : _terms[_index].indexOf(". (")),
                                style: TextStyle(
                                    color: Colors.lightBlue[900],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                          CupertinoButton(
                            child: Text("Next Fact"),
                            color: Colors.lightBlue[900],
                            onPressed: () {
                              setState(() {
                                if (_index < 132) {
                                  _index++;
                                } else {
                                  _index = 0;
                                  _terms.shuffle();
                                }
                              });
                            },
                          ),
                          CupertinoButton(
                            child: Text("Previous Fact"),
                            color: Colors.lightBlue[900],
                            onPressed: () {
                              setState(() {
                                if (_index>) {
                                  _index++;
                                } else {
                                  _index = 0;
                                  _terms.shuffle();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(
                  radius: 40,
                ))),
    );
  }
}
