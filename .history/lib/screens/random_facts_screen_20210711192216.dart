import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zero_day_shield/values/values.dart';

class RandomFactsScreen extends StatefulWidget {
  @override
  _RandomFactsScreenState createState() => new _RandomFactsScreenState();
}

class _RandomFactsScreenState extends State<RandomFactsScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  List<String> _terms = [];
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/facts.html'));
      document.getElementsByClassName("term").forEach((item) {
        setState(() {
          _terms.add(HtmlUnescape().convert(item.innerHtml));
        });
      });
      _terms.shuffle();
    } catch (e) {
      print(e);
    }
  }

  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    getGlos();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showfacts() {
    setState(() {
      if (_index < 132) {
        _index++;
      } else {
        _index++;
        _terms.shuffle();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Facts Randomized"),
          duration: const Duration(seconds: 2),
        ));
      }
      animationController.reset();
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: _terms.length == 133
            ? new Container(
                alignment: Alignment.centerLeft,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Align(
                        alignment: Alignment.topLeft,
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: new Text(
                            "Did you Know?",
                            style: new TextStyle(
                                color: Colors.black, fontSize: 30.0),
                          ),
                        )),
                    new Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 60.0),
                      child: new Opacity(
                        opacity: animation.value * 1,
                        child: new Transform(
                            transform: new Matrix4.translationValues(
                                0.0, animation.value * -50.0, 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: new RichText(
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                    softWrap: true,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: _terms[_index].substring(
                                                0,
                                                _terms[_index].indexOf(". (") ==
                                                        -1
                                                    ? _terms[_index]
                                                        .indexOf(". ")
                                                    : _terms[_index]
                                                        .indexOf(". (")),
                                            style: new TextStyle(
                                                color: Colors.lightBlue[900],
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    new MaterialButton(
                      color: Colors.lightBlue[900],
                      minWidth: 160.0,
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60.0, vertical: 18.0),
                        child: new Text(
                          "Show Another Fun Fact",
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                      onPressed: showfacts,
                    )
                  ],
                ),
              )
            : Center(
                child: CupertinoActivityIndicator(
                  radius: 40,
                ),
              ),
      ),
    );
  }
}
