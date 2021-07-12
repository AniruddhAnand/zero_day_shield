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
  TextEditingController _search = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/glossery.html'));
      document.getElementsByClassName("defintionHeader").forEach((item) {
        setState(() {
          _terms.add(HtmlUnescape().convert(item.innerHtml));
        });
      });
      document.getElementsByClassName("definitionCopy").forEach((item) {
        setState(() {
          _definitions.add(HtmlUnescape().convert(item.innerHtml));
        });
      });
      //}
    } catch (e) {}
  }

  @override
  void initState() {
    getGlos();
    _shown = _terms;
    _answers = _definitions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
