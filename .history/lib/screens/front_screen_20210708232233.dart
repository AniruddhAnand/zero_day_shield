import "package:flutter/material.dart";

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  String _attacks = "";
  void getGlos() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.spreadedu.org/gloss/glossery"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
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
    }
  }
  
  @override
  Widget build(BuildContext context) {
    String attacks = "";
    return Scaffold(
      body: Center(child: Text(attacks),),
    );
  }
}
