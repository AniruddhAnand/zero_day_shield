import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import '../values/values.dart';
import '../values/data.dart';

class ExpandedTile extends StatelessWidget {
  final Widget _text;
  final Widget _image;
  final String _title;
  ExpandedTile(this._text, this._image, this._title);

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          _title,
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[_image!=null?_image:Container(), Expanded(child: SingleChildScrollView(child: _text))],
          ),
        ),
    );
  }
}
                                