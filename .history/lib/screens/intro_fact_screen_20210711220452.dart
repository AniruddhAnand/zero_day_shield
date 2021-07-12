import 'dart:math';

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
  int _index = new Random().nextInt(133);
  Fact _fact;
  void getGlos() async {
    try {
      var document =
          parse(await rootBundle.loadString('assets/data/facts.html'));
      int count = 0;
      document.getElementsByClassName("term").forEach((item) {
        if (count == _index) {
          setState(() {
            String url = "";
            item.getElementsByTagName("A").forEach((item2) {
              if (url.compareTo("") == 0) {
                url = item2.attributes["href"];
              }
            });
            _fact = new Fact(HtmlUnescape().convert(item.innerHtml), url);
          });
        }
        count++;
      });
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Random Fact",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: _fact!=null
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
                                      text: _fact.fact.substring(
                                          0,
                                          _fact.fact.indexOf(". (") ==
                                                  -1
                                              ? _fact.fact
                                                  .indexOf(". ")
                                              : _fact.fact
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
                        new MaterialButton(
                          color: Colors.lightBlue[900],
                          minWidth: 160.0,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 18.0),
                            child: new Text(
                              "Ok",
                              style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _fact.launchURL();
                          },
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
