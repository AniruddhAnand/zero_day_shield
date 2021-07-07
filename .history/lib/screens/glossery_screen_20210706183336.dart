import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";

class GlosseryScreen extends StatefulWidget {
  @override
  _GlosseryScreenState createState() => _GlosseryScreenState();
}

class _GlosseryScreenState extends State<GlosseryScreen> {
  void getGlos() async {
    final response = await http.Client().get(
        Uri.parse("https://niccs.cisa.gov/about-niccs/cybersecurity-glossary"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      print(document.getElementsByClassName("definitionHeader"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
