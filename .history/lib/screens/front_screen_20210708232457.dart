import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  String _attacks = "";
  void getDailyAttacks() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.fireeye.com/cyber-map/threat-map.html"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      setState(() {
        _attacks = document.getElementById("totalAttacksToday").innerHtml;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("$_attacks",)),
    );
  }
}
