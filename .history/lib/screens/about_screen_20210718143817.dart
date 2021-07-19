import "package:flutter/material.dart";
import '../values/values.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'About',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Credits",
                  style: Styles.customTitleTextStyle(
                    color: AppColors.headingText,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.TEXT_SIZE_28,
                  ),
                ),
                RichText(
                  text:TextSpan(
                    style: TextStyle(color:Colors.black,height: 3),
                    children: [
                      TextSpan(
                        text:"Computer_Security Image: Wikimedia Commons\n"
                      ),
                    ]
                  ),
                ),
                Text(
                  "Credits",
                  style: Styles.customTitleTextStyle(
                    color: AppColors.headingText,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.TEXT_SIZE_28,
                  ),
                ),
                RichText(
                  text:TextSpan(
                    style: TextStyle(color:Colors.black,height: 3),
                    children: [
                      TextSpan(
                        text:"Computer_Security Image: Wikimedia Commons\n"
                      ),
                      TextSpan(
                        text:"Hacker Image: Chaiyapruek Youprasert\n"
                      ),
                      TextSpan(
                        text:"Encryption Image: Crypto Dost\n"
                      ),
                      TextSpan(
                        text:"Protection Image: iuriimotov\n"
                      ),
                      TextSpan(
                        text:"Score Image: Passatic\n"
                      ),
                      TextSpan(
                        text:"Phishing Image: Freepic\n"
                      ),
                      TextSpan(
                        text:"Nigerian Scam Text: Anorak\n"
                      ),
                      TextSpan(
                        text:"Voicemail Audio 1: Courier Video(Youtube)\n"
                      ),
                      TextSpan(
                        text:"Voicemail Audio 2: Scott Mulholland(Youtube)\n"
                      ),
                      TextSpan(
                        text:"Voicemail Audio 3: Conejo Valley Guide(Youtube)\n"
                      ),
                      TextSpan(
                        text:"Glossary: Cyberpolicy.com\n"
                      ),
                    ]
                  ),
                ),
                Text(
                  "Created and Developed by Aniruddh Anand",
                  style: Styles.customTitleTextStyle(
                    color: AppColors.headingText,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.TEXT_SIZE_20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
