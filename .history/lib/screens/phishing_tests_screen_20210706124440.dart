import 'package:zero_day_shield/widget/image_card.dart';

import 'nigerian_screen.dart';
import 'voicemail_screen.dart';
import '../widget/text_card.dart';
import '../values/values.dart';
import 'package:flutter/material.dart';
import '../values/data.dart';
import '../widget/spaces.dart';

class PhishingTestsScreen extends StatelessWidget {
  static const int TAB_NO = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Social Engineering Tests',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            SizedBox(child: Image.asset(ImagePath.socialEngineering)),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Sizes.MARGIN_16,
                right: Sizes.MARGIN_16,
                top: Sizes.MARGIN_16,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height - 600,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      // child: TextCard(
                      //   onTap: () {
                      //     if (index == 0) {
                      //       Navigator.push(
                      //           context,
                      //           new MaterialPageRoute(
                      //               builder: (ctx) => new NigerianScreen()));
                      //     } else {
                      //       Navigator.push(
                      //           context,
                      //           new MaterialPageRoute(
                      //               builder: (ctx) => new VoicemailScreen()));
                      //     }
                      //   },
                      //   cardTitle: testTitles[index],
                      //   description: testDescriptions[index],
                      //   color:true
                      // ),
                      child: ImageCard(
                        background: Image.asset(
                            "assets/images/background_${index == 0 ? "blue.jpeg" : "${index + 1}.png"}"),
                        title: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                testTitles[index],
                                style: TextStyle(
                                  fontFamily: 'BalooBhai',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                testDescriptions[index],
                                style: TextStyle(
                                  fontFamily: 'BalooBhai',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        index: index,
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (ctx) => new NigerianScreen()));
                          } else {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (ctx) => new VoicemailScreen()));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
