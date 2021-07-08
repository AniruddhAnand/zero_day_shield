import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import 'package:zero_day_shield/screens/expanded_tile.dart';
import 'package:zero_day_shield/values/values.dart';
import 'package:html_unescape/html_unescape.dart';

class GlosseryScreen extends StatefulWidget {
  @override
  _GlosseryScreenState createState() => _GlosseryScreenState();
}

class _GlosseryScreenState extends State<GlosseryScreen> {
  List<String> _terms = [];
  List<String> _definitions = [];
  List<String> _shown = [];
  List<String> _answers = [];
  bool _mod = false;
  bool _noShow = false;
  TextEditingController _search = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  void getGlos() async {
    try {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          title: Text(
            "Cyber Security Glossary",
            style: Styles.customTitleTextStyle(
              color: AppColors.headingText,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.TEXT_SIZE_22,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search Terms",
                  
                ),
                onChanged: (val) {
                  setState(() {
                    _mod = true;
                    if (val == "") {
                      _shown = _terms;
                      _answers = _definitions;
                    } else {
                      _shown = [];
                      _answers = [];
                      _terms.forEach((item) {
                        if (item.contains(val)) {
                          _shown.add(item);
                          _answers.add(_definitions[_terms.indexOf(item)]);
                        }
                      });
                    }
                    if (_shown.length == 0) {
                      _noShow = true;
                    } else {
                      _noShow = false;
                    }
                    _mod = false;
                  });
                },
              ),
              Expanded(
                child: _shown.length > 0 && !_mod
                    ? ListView.separated(
                        separatorBuilder: (context, item) => Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        controller: _scrollController,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (ctx) => new ExpandedTile(
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 60, left: 20, right: 20),
                                              child: RichText(
                                                softWrap: true,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: _shown[index],
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .headingText)),
                                                  TextSpan(text: "\n\n"),
                                                  TextSpan(
                                                      text: _answers[
                                                          index],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .accentText)),
                                                ]),
                                              ),
                                            ),
                                            null,
                                            "Term")));
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(_shown[index].length > 35
                                        ? "${_shown[index].substring(0, 30)}..."
                                        : _shown[index]),
                                    Icon(CupertinoIcons.arrow_right,
                                        color: Colors.blue)
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              )),
                        ),
                        itemCount: _shown.length,
                        //physics: CustomScrollPhysics(),
                      )
                    : Center(
                        child: _noShow
                            ? Text("No Available Terms")
                            : CupertinoActivityIndicator(
                                radius: 40,
                              ),
                      ),
              ),
            ],
          ),
        ));
  }
}
