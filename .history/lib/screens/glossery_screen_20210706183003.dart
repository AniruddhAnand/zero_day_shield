import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class GlosseryScreen extends StatelessWidget {
  void getGlos() async {
    final response = await http.Client().get(
        Uri.parse("https://niccs.cisa.gov/about-niccs/cybersecurity-glossary"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
