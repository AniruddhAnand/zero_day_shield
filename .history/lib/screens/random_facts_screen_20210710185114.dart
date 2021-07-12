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
    print(_terms.length);
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
        child: _terms.length==133?GestureDetector(
            child: RichText(
              text:TextSpan(
                children:[
                  TextSpan(
                    text:_terms[]
                  ),
                ]
              ),
            ),
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                setState(() {
                  _index--;
                  if (_index < 0) {
                    _index = _terms.length - 1;
                  }
                });
              } else if (details.delta.dy < -sensitivity) {
                setState(() {
                  _index++;
                  if (_index >= _terms.length) {
                    _index = 0;
                  }
                });
              }
            }):Center(child:CupertinoActivityIndicator(radius: 40,))
      ),
    );
  }
}
