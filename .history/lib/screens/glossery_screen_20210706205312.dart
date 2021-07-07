import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import 'package:zero_day_shield/values/values.dart';

class GlosseryScreen extends StatefulWidget {
  @override
  _GlosseryScreenState createState() => _GlosseryScreenState();
}

class _GlosseryScreenState extends State<GlosseryScreen> {
  var searchTerm = '';
  final _searchTextController = TextEditingController();
  List<String> _terms = [];
  List<String> _definitions = [];
  final _scrollController = new ScrollController();
  void getGlos() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.cyberpolicy.com/glossary"));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("defintionHeader").forEach((item) {
        setState(() {
          _terms.add(item.innerHtml);
        });
      });
      print( document.getElementsByClassName("defintionHeader").length);
      document.getElementsByClassName("definitionCopy").forEach((item) {
        setState(() {
          _definitions.add(item.innerHtml);
        });
      });
      print( document.getElementsByClassName("definitionCopy").length);
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
        title: TextField(
          controller: _searchTextController,
          onChanged: (text) {
            _scrollController.jumpTo(0);
            setState(() => searchTerm = text);
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Search...",
          ),
          autofocus: true,
        )
      ),
      body: _terms.length == 743
          ? ListView.separated(
            controller: _scrollController,
              separatorBuilder: (context, item) => Divider(
                color: Colors.black,
                height: 10,
              ),
              itemBuilder: (context, index) => ListTile(
                leading: Text(_terms[index]),
              ),
              itemCount: _terms.length,
            )
          : Center(
              child: CupertinoActivityIndicator(
                radius: 40,
              ),
            ),
    );
  }
}
