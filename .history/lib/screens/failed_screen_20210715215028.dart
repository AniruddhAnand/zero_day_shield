import "package:flutter/material.dart";

class FailedScreen extends StatelessWidget {
  String text = "Nothing Here";
  FailedScreen(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.lock),
            Text(text),
          ],
        ),
      ),
    );
  }
}
