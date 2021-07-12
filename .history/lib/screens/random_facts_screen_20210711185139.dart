import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zero_day_shield/values/values.dart';

class RandomFactsScreen extends StatefulWidget {
  @override
  _RandomFactsScreenState createState() => _RandomFactsScreenState();
}

class _RandomFactsScreenState extends State<RandomFactsScreen> {
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
    } catch (e) {}
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
          "Cyber Security Glossary",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
          child: _terms.length == 133
              ? GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            softWrap: true,
                            text: TextSpan(children: [
                              TextSpan(
                                text: _terms[_index].substring(
                                    0,
                                    _terms[_index].indexOf(". (") == -1
                                        ? _terms[_index].indexOf(". ")
                                        : _terms[_index].indexOf(". (")),
                                style: TextStyle(
                                    color: Colors.lightBlue[900],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CupertinoButton(
                            child: Text("Next Fact"),
                            color: Colors.lightBlue[900],
                            onPressed: () {
                              setState(() {
                                if (_index < 132) {
                                  _index++;
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Facts Randomized"),
                                    duration: const Duration(seconds: 2),
                                  ));
                                  _index = 0;
                                  _terms.shuffle();
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CupertinoButton(
                            child: Text("Previous Fact"),
                            color: Colors.lightBlue[900],
                            onPressed: () {
                              setState(() {
                                if (_index > 0) {
                                  _index--;
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("No Previous Facts"),
                                    duration: const Duration(seconds: 2),
                                  ));
                                  _index = 0;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(
                  radius: 40,
                ))),
    );
  }
}
void main() => runApp(new MaterialApp(
      home: new Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  int factcounter = 0;
  int colorcounter = 0;
  @override
  void initState() {
    super.initState();
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
      dispfact = facts[factcounter];
      dispcolor = bgcolors[colorcounter];
      factcounter = factcounter < facts.length - 1 ? factcounter + 1 : 0;
      colorcounter = colorcounter < bgcolors.length - 1 ? colorcounter + 1 : 0;
      animationController.reset();
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: dispcolor,
      body: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Align(
                  alignment: Alignment.topLeft,
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Did you Know?",
                      style: new TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  )),
              new Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 60.0),
                child: new Opacity(
                  opacity: animation.value*1,
                                  child: new Transform(
                    transform: new Matrix4.translationValues(0.0,animation.value*-50.0, 0.0),
                      child: new Text(
                    dispfact,
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  )),
                ),
              ),
              new MaterialButton(
                color: Colors.white,
                minWidth: 160.0,
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 18.0),
                  child: new Text(
                    "Show Another Fun Fact",
                    style: new TextStyle(fontSize: 15.0,color: dispcolor),
                  ),
                ),
                onPressed: showfacts,
              )
            ],
          ),
        ),
      ),
    );
  }
}

