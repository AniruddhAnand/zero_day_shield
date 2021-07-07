import 'package:flutter/material.dart';
import '../values/values.dart';

class IconCard extends StatelessWidget {
  final Icon imagePath;
  final String cardTitle;
  final String description;
  final GestureTapCallback onTap;
  final double width;
  final double cardHeight;
  final double imageHeight;
  final double cardElevation;

  IconCard({
    this.imagePath,
    this.cardTitle,
    this.description,
    this.width = 85.0,
    this.cardHeight = 100.0,
    this.imageHeight = 45.0,
    this.onTap,
    this.cardElevation = 4.0,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: cardHeight,
        child: Card(
          color:Colors.grey[300],
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Column(
                  children: <Widget>[
                    imagePath,
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Sizes.MARGIN_16,
                        vertical: Sizes.MARGIN_16,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                cardTitle,
                                textAlign: TextAlign.left,
                                style: Styles.customTitleTextStyle(
                                  color: AppColors.headingText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

