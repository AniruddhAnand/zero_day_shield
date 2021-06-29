import 'phishing_tests_screen.dart';
import 'scoring_screen.dart';

import '../values/values.dart';
import 'package:flutter/material.dart';
import '../values/data.dart';
import '../widget/info_card.dart';
import '../widget/spaces.dart';

class SecurityTestsScreen extends StatelessWidget {
  static const int TAB_NO = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Security Tests',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.only(
            left: Sizes.MARGIN_16,
            right: Sizes.MARGIN_16,
            top: Sizes.MARGIN_16,
          ),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: 2,
            separatorBuilder: (context, index) {
              return SpaceH8();
            },
            itemBuilder: (context, index) {
              return Container(
                child: InfoCard(
                  onTap: () {
                    index==0?
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (ctx)=>new ScoringScreen())):
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (ctx)=>new PhishingTestsScreen()))
                    ;
                  },
                  imagePath: scoreImagePaths[index],
                  cardTitle: scoreTitles[index],
                  description: scoreDescriptions[index],
                ),
              );
            },
          )),
    );
  }
}
