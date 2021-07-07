import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";

class GlosseryScreen extends StatefulWidget {
  @override
  _GlosseryScreenState createState() => _GlosseryScreenState();
}

class _GlosseryScreenState extends State<GlosseryScreen> {
  List<String> _terms = [];
  void getGlos() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.cyberpolicy.com/glossary"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("defintionHeader").forEach((item) {
        _terms.add(item.innerHtml);
      });
    }
  }

  @override
  void initState() {
    getGlos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
