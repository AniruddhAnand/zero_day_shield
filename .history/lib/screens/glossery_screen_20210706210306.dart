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
        title: Text(
          "Cyber Security Glossery",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
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
               physics: CustomScrollPhysics(),
            )
          : Center(
              child: CupertinoActivityIndicator(
                radius: 40,
              ),
            ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final tolerance = this.tolerance;
    if ((velocity.abs() < tolerance.velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return null;
    }
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      friction: .1,    // <--- HERE
      tolerance: tolerance,
    );
  }
}
