import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class BiometricTransitionScreen extends StatelessWidget {
  initiSta
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
        child: WidgetCircularAnimator(
          size: 250,
          innerIconsSize: 3,
          outerIconsSize: 3,
          innerAnimation: Curves.easeInOutBack,
          outerAnimation: Curves.easeInOutBack,
          innerColor: Colors.deepPurple,
          outerColor: Colors.orangeAccent,
          innerAnimationSeconds: 10,
          outerAnimationSeconds: 10,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
            child: Image.asset(
              "assets/images/app_logo.png"
            ),
          ),
        ),
      )
    );
  }
}