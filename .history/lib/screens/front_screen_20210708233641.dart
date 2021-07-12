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
    try {
      final response = await http.Client()
          .get(Uri.parse("https://www.fireeye.com/cyber-map/threat-map.html"));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        if (mounted) {
          setState(() {
            _attacks = document.getElementById("totalAttacksToday").className;
          });
        }
        print(_attacks);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDailyAttacks();
    return Scaffold(
      body: Center(
          child: Text(
        "Total Cyber Attacks: $_attacks",
      )),
    );
  }
}
