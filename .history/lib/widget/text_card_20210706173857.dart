import 'package:flutter/material.dart';
import '../values/values.dart';

class TextCard extends StatelessWidget {
  final String cardTitle;
  final String description;
  final GestureTapCallback onTap;
  final double width;
  final double cardHeight;
  final double cardElevation;
  final bool color;
  final String time;

  TextCard({
    this.cardTitle,
    this.description,
    this.width = 340.0,
    this.cardHeight = 150.0,
    this.onTap,
    this.cardElevation = 4.0,
    this.color,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: cardHeight,
        child: Card(
          color: /*color ? Color.fromRGBO(68, 108, 148, 1) :*/ Color.fromRGBO(242,241,246,1),
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Sizes.MARGIN_16,
                        vertical: Sizes.MARGIN_16,
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Card(
                                color: Colors.lightBlue[900],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    time,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: Styles.customTitleTextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.TEXT_SIZE_14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text(
                                cardTitle,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: Styles.customTitleTextStyle(
                                  color: /*color ? Colors.white :*/ Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.TEXT_SIZE_20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text(
                                description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: Styles.customNormalTextStyle(
                                  color:/* color
                                      ? Colors.grey[200]
                                      : */Colors.lightBlue[900],
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                              ),
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
