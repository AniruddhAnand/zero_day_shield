import "package:flutter/material.dart";

class FailedScreen extends StatelessWidget {
  String text = "";
  FailedScreen(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Nothing here"),
      ),
    );
  }
}
