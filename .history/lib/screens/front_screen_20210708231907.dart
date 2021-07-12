import "package:flutter/material.dart";

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    String attacks = "";
    return Scaffold(
      body: Center(child: Text(attacks),),
    );
  }
}
