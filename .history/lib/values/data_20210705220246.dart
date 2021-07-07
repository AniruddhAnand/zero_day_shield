import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/encryption_screen.dart';
import '../screens/generator_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../values/values.dart';
import 'package:expansion_card/expansion_card.dart';

BuildContext buildContext;

List<String> titles = [
  "Computer Security",
  "Security Threats",
  "Encryption",
  "Prevention"
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
                      "Grades to payments to taxes to retirement funds are managed online, so there must be a way to protect these assets. Computer security is the protection of systems, devices and digital assets.",
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionCard(
            background: Image.asset("assets/images/background_2.png"),
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
                    "- Confidentiality guarantees that data ",
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
            background: Image.asset("assets/images/background_2.png"),
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
            background: Image.asset("assets/images/background_2.png"),
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
        ],
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: RichText(
        softWrap: true,
        textAlign: TextAlign.left,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Encryption is the obfuscation of data so that only the proper recipients can understand. As hackers become more inept at intercepting transmissions, encryption's importance increases. Encryption can be as simple as moving every letter up to one letter(a->b) or as complex as converting text to binary, tripling the string, and running an XOR through the resulting string using a large key. Web browsers can even use encryption to verify the safety of connections of websites.\n\nEncryption, when taken to the extreme, becomes Hashing. Irreversibly encrypted data, hashes cannot be cracked and are extremely important. For example, when a user enters the password for their device, the system will not decrypt the stored password to check but will hash the password entered to see if the hashes match.\n\nHackers, though, have become smart and can attempt to get around hashes. One way is using a rainbow table. If a hacker can get the hashes of a user's computer, they can run the hashes through a rainbow table. Since hashes are uncrackable, some individuals will take common passwords, hash the passwords themselves, and save the result. Now without having to decrypt the hash, hackers can decipher guessable passwords from their hash.\n\nAnother way is using the birthday method. Similar to how many people share the same birthday, some strings will have the same hash. If a hacker can find the birthday hash, they may crack passwords without even knowing the correct password. On the bright side, these attacks are not very feasible.\n\nOn the bright side, attempting to take hash data from a computer requires lots of searching, and finding a birthday hash could take years. This app includes a simple ",
            ),
            TextSpan(
                text: "encryption demo",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (context) => new EncryptionScreen()));
                  }),
            TextSpan(
              text: " for refrence purposes.",
            ),
          ],
        ),
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: RichText(
        textAlign: TextAlign.left,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Preventing hackers and other online criminals from stealing digital assets comes in two forms: user prevention and built-in prevention.\n\nUser Prevention refers to methods the user should learn and apply in their day to day life to be more secure. When it comes to hacking, it is usually easier to attack a person than attack a computer because people naturally trust others. Social Engineers take advantage of this to extract information. Users should remember never to give out personal information over any form of communication unless 100% sure that it is being given to the proper authorities. Also, passwords should never be simple strings as they can easily be guessed or cracked. Hackers can use dictionaries and cracking programs to guess a password, even if it is made of multiple words. The most secure passwords are at least 7-8 digits and are made of random strings. There is a ",
            ),
            TextSpan(
                text: "password generator",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (context) => new GeneratorScreen()));
                  }),
            TextSpan(
              text:
                  " available in this app, where users can generate secure random passwords, name the passwords, and save the passwords. The saved passwords are secured by biometric authentication",
            ),
            TextSpan(
              text:
                  "(Only the user who owns the phone can access the saved passwords)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  ". The passwords are stored in the phone using AES encryption",
            ),
            TextSpan(
              text:
                  "(See previous tile for more information regarding encryption)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ".\n\nUsers should have anti-virus software installed on their computers to prevent malware attacks along with a firewall. In addition, users who work with confidential information should monitor the ports on their computer"),
            TextSpan(
              text: "(usb, headphone-jack, ethernet)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    " to ensure no unknown devices are plugged in because hackers may try to infiltrate a work environment and plug in an almost invisible key logger device into a computer."),
          ],
        ),
      ))
];
