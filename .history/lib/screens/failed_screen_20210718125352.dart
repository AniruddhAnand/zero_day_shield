import "package:flutter/material.dart";

// ignore: must_be_immutable
class FailedScreen extends StatelessWidget {
  String _text = "Nothing Here";
  FailedScreen(this._text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock),
            Text(_text),
          ],
        ),
      ),
    );
  }
}
