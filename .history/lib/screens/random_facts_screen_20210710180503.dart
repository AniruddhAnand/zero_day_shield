import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:zero_day_shield/screens/expanded_tile_screen.dart';
import 'package:zero_day_shield/values/values.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;

class RandomFactsScreen extends StatefulWidget {
  @override
  _RandomFactsScreenState createState() => _RandomFactsScreenState();
}

class _RandomFactsScreenState extends State<RandomFactsScreen> {
  List<String> _terms = [];
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/facts.html'));
      document.getElementsByTagName("li").forEach((item) {
        print
        setState(() {
          _terms.add(HtmlUnescape().convert(item.innerHtml));
        });
      });
      print(_terms);
    } catch (e) {}
  }

  @override
  void initState() {
    getGlos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
