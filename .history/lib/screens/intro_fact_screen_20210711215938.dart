import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zero_day_shield/screens/glossery_screen.dart';
import 'package:zero_day_shield/values/values.dart';
import 'package:zero_day_shield/widget/fact.dart';

class IntroFactScreen extends StatefulWidget {
  @override
  _IntroFactScreenState createState() => new _IntroFactScreenState();
}

class _IntroFactScreenState extends State<IntroFactScreen>
    with SingleTickerProviderStateMixin {
      
  int _index = 0;
  List<Fact> _terms = [];
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/facts.html'));
      document.getElementsByClassName("term").forEach((item) {
        setState(() {
          String url = "";
          item.getElementsByTagName("A").forEach((item2) {
            if (url.compareTo("") == 0) {
              url = item2.attributes["href"];
            }
          });
          _terms.add(new Fact(HtmlUnescape().convert(item.innerHtml), url));
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
        _index = 0;
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
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Cyber Security Facts",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
        actions: [
          TextButton(
            child: Container(
              child: Card(
                color: Colors.lightBlue[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Glossary",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: Styles.customTitleTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.TEXT_SIZE_14,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => GlosseryScreen(),
                ),
              );
            },
          ),
        ],
      ),
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
                                color: Colors.blue, fontSize: 30.0),
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
                            child: new RichText(
                              textAlign: TextAlign.left,
                              softWrap: true,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: _terms[_index].fact.substring(
                                          0,
                                          _terms[_index].fact.indexOf(". (") ==
                                                  -1
                                              ? _terms[_index]
                                                  .fact
                                                  .indexOf(". ")
                                              : _terms[_index]
                                                  .fact
                                                  .indexOf(". (")),
                                      style: new TextStyle(
                                          color: Colors.lightBlue[900],
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new IconButton(
                          color: Colors.blue,
                          icon: Icon(
                            Icons.arrow_circle_down,
                            size: 40,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_index > 0) {
                                _index--;
                              }
                            });
                            animationController.reset();
                            animationController.forward();
                          },
                        ),
                        new MaterialButton(
                          color: Colors.lightBlue[900],
                          minWidth: 160.0,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 18.0),
                            child: new Text(
                              "Learn More",
                              style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _terms[_index].launchURL();
                          },
                        ),
                        new IconButton(
                          color: Colors.blue,
                          icon: Icon(
                            Icons.arrow_circle_up,
                            size: 40,
                          ),
                          onPressed: showfacts,
                        ),
                      ],
                    ),
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
