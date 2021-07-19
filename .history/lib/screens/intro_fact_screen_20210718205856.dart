import 'dart:math';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:html/parser.dart";
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zero_day_shield/screens/home_screen.dart';
import 'package:zero_day_shield/values/values.dart';
import 'package:zero_day_shield/widget/fact.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

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
        vsync: this, duration: new Duration(seconds: 4));
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
    return WillPopScope(
      onWillPop: ()async,
      child: new Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          centerTitle: true,
          title: Text(
            "Did you Know?",
            style: Styles.customTitleTextStyle(
              color: AppColors.headingText,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.TEXT_SIZE_22,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: _fact != null
                ? new Container(
                    alignment: Alignment.center,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                                              _fact.fact.indexOf(". (") == -1
                                                  ? _fact.fact.indexOf(". ")
                                                  : _fact.fact.indexOf(". (")),
                                          style: new TextStyle(
                                              color: Colors.lightBlue[900],
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height <=
                                                      667
                                                  ? 16.0
                                                  : 25,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        WidgetCircularAnimator(
                          size: MediaQuery.of(context)
                                                          .size
                                                          .height <
                                                      667
                                                  ?150:250,
                          innerIconsSize: 3,
                          outerIconsSize: 3,
                          innerAnimation: Curves.easeInOutBack,
                          outerAnimation: Curves.easeInOutBack,
                          innerColor: Colors.deepPurple,
                          outerColor: Colors.orangeAccent,
                          innerAnimationSeconds: 10,
                          outerAnimationSeconds: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey[200]),
                            child: Opacity(
                              child: Image.asset(
                                "assets/images/app_icon_2.png",
                                scale: MediaQuery.of(context).size.height < 667
                                    ? 2
                                    : 1,
                              ),
                              opacity: .65,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        new MaterialButton(
                          color: Colors.lightBlue[900],
                          minWidth: 160.0,
                          child: new Padding(
                            padding: MediaQuery.of(context).size.height <= 568
                                ? const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 18.0)
                                : const EdgeInsets.symmetric(
                                    horizontal: 60.0, vertical: 18.0),
                            child: new Text(
                              "Ok",
                              style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement<void, void>(
                                context,
                                new MaterialPageRoute(
                                    builder: (ctx) => HomeScreen()));
                          },
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
        ),
      ),
    );
  }
}
