import 'package:flutter/cupertino.dart';
import 'about_screen.dart';

import '../values/values.dart';
import 'package:flutter/material.dart';
import '../values/data.dart';
import '../widget/info_card.dart';
import '../widget/spaces.dart';
import "expanded_tile.dart";

class HomeTabScreen extends StatelessWidget {
  static const int TAB_NO = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Home',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
        actions: [
          IconButton(
            icon:Icon(CupertinoIcons.info),
            onPressed: (){
              Navigator.push(context,new MaterialPageRoute(builder: (context)=> new AboutScreen()));
            },
          ),
        ],
      ),
      body: Container(
          margin: const EdgeInsets.only(
            left: Sizes.MARGIN_16,
            right: Sizes.MARGIN_16,
            top: Sizes.MARGIN_16,
          ),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: 4,
            separatorBuilder: (context, index) {
              return SpaceH8();
            },
            itemBuilder: (context, index) {
              return Container(
                child: InfoCard(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ExpandedTile(
                                  fullTexts[index],
                                  SizedBox(
                                    child: Image.asset(
                                        imagePaths[index],),
                                  ),
                                  titles[index],
                                )));
                  },
                  imagePath: imagePaths[index],
                  cardTitle: titles[index],
                  //bookmark: true,
                  description: descriptions[index],
                ),
              );
            },
          )),
    );
  }
}