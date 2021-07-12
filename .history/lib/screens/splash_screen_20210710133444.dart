import 'package:flutter/material.dart';

import '../values/values.dart';
import "home_screen.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _imageController;
  AnimationController _textController;
  AnimationController _sloganController;
  Animation<double> _imageAnimation;
  Animation<double> _textAnimation;
  Animation<double> _sloganAnimation;
  bool hasImageAnimationStarted = false;
  bool hasTextAnimationStarted = false;
  bool hasSloganAnimationStarted = false;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _sloganController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _imageAnimation =
        Tween<double>(begin: 1, end: 1.5).animate(_imageController);
    _textAnimation = Tween<double>(begin: 3, end: 0.5).animate(_textController);
    _sloganAnimation =
        Tween<double>(begin: 3, end: 0.5).animate(_sloganController);
    _imageController.addListener(imageControllerListener);
    _textController.addListener(textControllerListener);
    _sloganController.addListener(sloganControllerListener);
    run();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void imageControllerListener() {
    if (_imageController.status == AnimationStatus.completed) {
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.popAndPushNamed(context, HomeScreen.route);
      });
    }
  }

  void textControllerListener() {
    if (_textController.status == AnimationStatus.completed) {
      Future.delayed(Duration(milliseconds: 1000), () {
      });
    }
  }

  void sloganControllerListener() {
    if (_sloganController.status == AnimationStatus.completed) {
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          hasImageAnimationStarted = true;
        });
        _imageController.forward().orCancel;
      });
    }
  }

  void run() {
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        hasTextAnimationStarted = true;
        hasSloganAnimationStarted = true;
      });
      _textController.forward().orCancel;
      _sloganController.forward().orCancel;
    });
  }

  @override
  dispose() {
    _imageController.dispose();
    _textController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            hasTextAnimationStarted
                ? Center(
                    child: AnimatedBuilder(
                      animation: _textController,
                      child: Text(
                        'ZeroDay Shield', 
                        textAlign: TextAlign.center,
                        style: Styles.customTitleTextStyle(
                          color: AppColors.headingText,
                        ),
                      ),
                      builder: (context, child) => Transform.scale(
                        scale: 2 * _textAnimation.value,
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
                  )
                : Container(),
            hasImageAnimationStarted?AnimatedBuilder(
              animation: _imageController,
              child: Image.asset(
                "assets/images/app_icon.png", 
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              builder: (context, child) => RotationTransition(
                turns: hasImageAnimationStarted
                    ? Tween(begin: 1.0, end: 2.0).animate(_imageController)
                    : Tween(begin: 180.0, end: 0.0).animate(_imageController),
                child: Transform.scale(
                  scale: .7 * _imageAnimation.value,
                  child: child,
                ),
              ),
            ):Container(),
            hasSloganAnimationStarted
                ? Center(
                    child: AnimatedBuilder(
                      animation: _sloganAnimation,
                      child: Text(
                        'Secure your digital assets', 
                        textAlign: TextAlign.center,
                        style: Styles.customTitleTextStyle(
                          color: AppColors.headingText,
                        ),
                      ),
                      builder: (context, child) => Transform.scale(
                        scale: 2 * _sloganAnimation.value,
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
