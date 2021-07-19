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
                RichText(
                  text:TextSpan(
                    style: TextStyle(color:Colors.black,height: 3),
                    children: [
                      TextSpan(
                        text:"ZeroDay Shield is the ultimate computer security educational tool. Get educated, get secure, and learn to protect digital assets.\n\nZeroDay Shield gives you all the information needed to learn, be informed, and stay protected from digital thefts. This app not only educates users with the learning center, encryption demo, and social engineering tests, but also provides tools: password generator, password vault, password strength/compromise checker, latest cyber security news, important facts, and cyber security glossary.\n\nZeroDay Shield is a one stop learning for all your computer security needs."
                      ),
                    ]
                  ),
                ),
                Text(
                  "Credits",
                  style: Styles.customTitleTextStyle(
                    color: AppColors.headingText,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.TEXT_SIZE_20
                  ),
                ),
                RichText(
                  text:TextSpan(
                    style: TextStyle(color:Colors.black,height: 3),
                    children: [
                      TextSpan(
                        text:"Computer_Security Image: Wikimedia Commons\nHacker Image: Chaiyapruek Youprasert\nEncryption Image: Crypto Dost\nProtection Image: iuriimotov\n"
                      ),
                      TextSpan(
                        text:""
                      ),
                      TextSpan(
                        text:""
                      ),
                      TextSpan(
                        text:""
                      ),
                      TextSpan(
                        text:""
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
