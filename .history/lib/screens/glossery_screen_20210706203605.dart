import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";

class GlosseryScreen extends StatefulWidget {
  @override
  _GlosseryScreenState createState() => _GlosseryScreenState();
}

class _GlosseryScreenState extends State<GlosseryScreen> {
  List<String> _terms = [];
  List<String> _definitions = [];
  void getGlos() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.cyberpolicy.com/glossary"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("defintionHeader").forEach((item) {
        _terms.add(item.innerHtml);
      });
      document.getElementsByClassName("definitionCopy").forEach((item) {
        _definitions.add(item.innerHtml);
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
    return Scaffold(
      appBar: AppBar(
          elevation: 5.0,
          title: Text(
            "Cyber Security News",
            style: Styles.customTitleTextStyle(
              color: AppColors.headingText,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.TEXT_SIZE_22,
            ),
          ),
        ),
    );
  }
}
