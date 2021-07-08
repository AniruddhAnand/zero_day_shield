import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zero_day_shield/screens/phishing_tests_screen.dart';
import '../screens/encryption_screen.dart';
import '../screens/generator_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../values/values.dart';
import 'package:expansion_card/expansion_card.dart';

BuildContext buildContext;

double expandHeight = 0;
List<String> titles = [
  "Computer Security",
  "Security Threats",
  "Encryption",
  "Best Practices"
];

List<String> recording = [
  'assets/audio/irs_recording.mp3',
  'assets/audio/irs_scam_2.mp3',
  'assets/audio/irs_scam_3.mp3',
];

List<String> scoreTitles = ["Password Tester", "Social Engineering Tests"];

List<String> testTitles = [
  "Nigerian Scam",
  "IRS Scam",
  "Email Phising(Bank) Scam"
];

List<String> imagePaths = [
  ImagePath.computerSecurity,
  ImagePath.hackerImage,
  ImagePath.privateKey,
  ImagePath.sheildPrevention
];

List<String> scoreImagePaths = [
  ImagePath.scoreImage,
  ImagePath.socialEngineering,
];

List<String> descriptions = [
  "Computer security is the protection of systems, devices and digital assets.",
  "Life has transitioned to the digital world, and so have criminals.",
  "Encryption is the obfuscation of data, so that only the proper recipients can understand.",
  "Prevent hackers from stealing your digital assets."
];

List<String> scoreDescriptions = [
  "Check the strength of your password along with whether it has become compromised",
  "Test yourself against famous online scams",
];
List<String> testDescriptions = [
  "Test yourself against nigerian scammers",
  "Test yourself against irs scammers",
  "Test yourself against email scammers",
];

List<Gradient> gradients = [
  Gradients.italianGradient,
  Gradients.chineseGradient,
  Gradients.mexicanGradient,
  Gradients.thaiGradient,
  Gradients.arabianGradient,
  Gradients.indianGradient,
  Gradients.americanGradient,
  Gradients.koreanGradient,
];

List<Widget> fullTexts = [
  //padding is a full text
  Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.left,
            softWrap: true,
            text: TextSpan(
              style: TextStyle(
                  /*fontFamily: "BlackChancery",*/ color: Colors.black,
                  fontSize: 14),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Grades to payments to taxes to retirement funds are managed online, so there must be a way to protect these assets. Computer security is the protection of systems, devices and digital assets. The CIA Triad is the foundation for computer security.",
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_6.png"),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(buildContext).size.height < 667 ? expandHeight : 0,
            ),
            onExpansionChanged: (expand){
              expandHeight = expand? 30:
            },
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "CIA Triad",
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    "- Confidentiality guarantees that data cannot be accessed by unauthorized users\n\n- Integrity guarantees that data is unaltered\n\n- Availability guarentees systems are available to authorized users",
                    style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 14,
                        color: Colors.white)),
              )
            ],
          ),
        ],
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.left,
            softWrap: true,
            text: TextSpan(
              style: TextStyle(
                  /*fontFamily: "BlackChancery",*/ color: Colors.black,
                  fontSize: 14),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Life has transitioned to the digital world, and so have criminals. They use a multitude of skills to steal information.",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_blue.jpeg"),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Social Engineering",
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    "- Phishing is where an attacker sends a fraudulent message to trick a victim into revealing sensitive information.\n\n- Dumpster Diving is the act of gathering discarded documents/data to steal sensitive information",
                    style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 14,
                        color: Colors.white)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_9.png"),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Online Scams",
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    "- Nigerian Scams are famous for promising large sums of money in return for small up front fees\n\n- IRS Scams will have callers impersonating the IRS threatening the victim for failing to pay tax dues",
                    style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 14,
                        color: Colors.white)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_blue.jpeg"),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Malware & Viruses",
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    "- Malware are programs designed to damage systems.\n\n- Viruses attach to system files to cause harm.\n\n- Notable malware and virusses include keyloggers, trojans, and polymorphic virus",
                    style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 14,
                        color: Colors.white)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_9.png"),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ransomware",
                    style: TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    "- Ransomware is a type of malware threatens to publish the victim's sensitive data or block access to it unless a ransom is paid",
                    style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 14,
                        color: Colors.white)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
                text: "Test yourself against famous online scams",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      buildContext,
                      new MaterialPageRoute(
                          builder: (ctx) => new PhishingTestsScreen()),
                    );
                  }),
          ),
        ],
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
              softWrap: true,
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(
                    /*fontFamily: "BlackChancery",*/ color: Colors.black,
                    fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "Encryption is the obfuscation of data so that only the proper recipients can understand. As hackers become more inept at intercepting transmissions, encryption's importance increases.",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionCard(
              background: Image.asset("assets/images/background_5.png"),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Encryption",
                      style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                      "- Encryption can be as simple as substitution(Ex: a -> b)\n\n- Encryption can also be as complex as converting to binary, pushing through xor, and using mathematical formulas.",
                      style: TextStyle(
                          fontFamily: 'BalooBhai',
                          fontSize: 14,
                          color: Colors.white)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionCard(
              background: Image.asset("assets/images/background_4.png"),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hashing",
                      style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                      "- Hashing is irreversible encryption and are vulnerable to rainbow tables and birthday attacks.\n\n- Rainbow tables save known hashes with their passwords and Birthday attacks attempt to find a password with the same hash",
                      style: TextStyle(
                          fontFamily: 'BalooBhai',
                          fontSize: 14,
                          color: Colors.white)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Encryption Demo",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (ctx) => new EncryptionScreen()),
                      );
                    }),
            ),
          ],
        ),
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.left,
              softWrap: true,
              text: TextSpan(
                style: TextStyle(
                    /*fontFamily: "BlackChancery",*/ color: Colors.black,
                    fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "Due to the rise in security threats, users must be armed with best security practices to neutralize threats.",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionCard(
              background: Image.asset("assets/images/background_7.png"),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Software Protection",
                      style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                      "- Install and update malware/antivirus programs from reputable vendors(Mcafee, Symantec, F-Secure)\n\n- Have anti-phishing software installed(Microsoft Edge Smart Screen Filter).",
                      style: TextStyle(
                          fontFamily: 'BalooBhai',
                          fontSize: 14,
                          color: Colors.white)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionCard(
              background: Image.asset("assets/images/background_8.png"),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "User Defense",
                      style: TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                      "- Avoid opening links or emails from unknown sources.\n\n- Change passwords regularly with 8+ characters of length and special characters\n\n- Periodically back up documents",
                      style: TextStyle(
                          fontFamily: 'BalooBhai',
                          fontSize: 14,
                          color: Colors.white)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Secure Password Generator",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (ctx) => new GeneratorScreen()),
                      );
                    }),
            ),
          ],
        ),
      ))
];
