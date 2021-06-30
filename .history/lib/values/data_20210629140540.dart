import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zero_day_shield/screens/phishing_tests_screen.dart';
import '../screens/encryption_screen.dart';
import '../screens/generator_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../values/values.dart';

BuildContext buildContext;

List<String> titles = [
  "Computer Security",
  "Online Threats",
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
  "Computer security is the protection of your devices and digital assets.",
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
      child: RichText(
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Computer security is the protection of your devices and digital assets. Nowadays, everything is managed online, from grades to payments to taxes to retirement funds. These assets affect people of all ages and at every level. Due to this, there must be a way to protect your digital assets from online criminals. Computer Security knowledge allows experts to police the digital world and regular pedestrians surfing the web to defend themselves.",
            )
          ],
        ),
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: RichText(
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Life has transitioned to the digital world, and so have criminals. They use a multitude of skills to steal information from unassuming individuals. One such technique is called social engineering. For example, Social engineering uses trust, manipulation, impersonation, and ",
            ),
            TextSpan(
                text: "dumpster diving ",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await canLaunch(
                            "https://en.wikipedia.org/wiki/Dumpster_diving")
                        ? await launch(
                            "https://en.wikipedia.org/wiki/Dumpster_diving")
                        : throw 'Could not launch https://en.wikipedia.org/wiki/Dumpster_diving';
                  }),
            TextSpan(
              text:
                  "to steal information from individuals. Often they extract password information by inquiring about pets, family members etc., and may get private information about a company by masquerading as an employee. They can even steal money by pretending to be IRS agents or celebrities. ",
            ),
            TextSpan(
                text: "Test yourself against famous online scams here.",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (ctx) => new PhishingTestsScreen()));
                  }),
            TextSpan(
              text:
                  "\n\nUsers should also be aware of Hackers as an online threat. Without direct access to your device, hackers cannot do much, but they can use malware to cause harm. Malware is any program that hopes to cause damage to a system. Malware can log keystrokes",
            ),
            TextSpan(
                text: "(Keylogger)",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await canLaunch(
                            "https://en.wikipedia.org/wiki/Keystroke_logging")
                        ? await launch(
                            "https://en.wikipedia.org/wiki/Keystroke_logging")
                        : throw 'Could not launch https://en.wikipedia.org/wiki/Keystroke_logging';
                  }),
            TextSpan(
              text: ", pretend to be a safe program",
            ),
            TextSpan(
                text: "(Trojan)",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await canLaunch(
                            "https://en.wikipedia.org/wiki/Trojan_horse_(computing)")
                        ? await launch(
                            "https://en.wikipedia.org/wiki/Trojan_horse_(computing)")
                        : throw 'Could not launch https://en.wikipedia.org/wiki/Trojan_horse_(computing)';
                  }),
            TextSpan(text: ", or even change its code to hide from scanners"),
            TextSpan(
                text: "(Polymorphic)",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await canLaunch(
                            "https://en.wikipedia.org/wiki/Polymorphic_code")
                        ? await launch(
                            "https://en.wikipedia.org/wiki/Polymorphic_code")
                        : throw 'Could not launch https://en.wikipedia.org/wiki/Polymorphic_code';
                  }),
            TextSpan(
              text:
                  ". With all these threats looming around, users need a way to be as secure as possible.",
            ),
          ],
        ),
      )),
  Padding(
      padding: EdgeInsets.all(20),
      child: RichText(
        softWrap: true,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Encryption is the obfuscation of data so that only the proper recipients can understand. As hackers become more inept at intercepting transmissions, encryption's importance increases. Encryption can be as simple as moving every letter up to one letter(a->b) or as complex as converting text to binary, tripling the string, and running an XOR through the resulting string using a large key. Web browsers can even use encryption to verify the safety of connections of websites.\n\nEncryption, when taken to the
extreme, becomes Hashing. Irreversibly encrypted data, hashes cannot be cracked and are extremely
\important. For example, when a user enters the password for their device, the system will not decrypt
the stored password to check but will hash the password entered to see if the hashes
match.\n\nHackers, though, have become smart and can attempt to get around hashes. One way is using a rainbow table. If a hacker is able to get the hashes of a user's computer they can run the hashes through a rainbow table. Since hashes are uncrackable, some individuals will take common passwords and hash the passwords themselves and save the result. Now without having to decrypt the hash, hackers are able to decipher some hashes.\n\nAnother way is using the birthday method. Similar to how many people share the same birthday, some string will have the same hash. If a hacker can find the birthday hash, they may be able to crack passwords without even finding the correct password.\n\nOn the bright side, these attacks are not very feasible. Attempting to take hash data from a computer require lots of searching and finding a birthday hash could take years. This app includes a simple ",
            ),
            TextSpan(
                text: "encryption demo",
                style: TextStyle(fontWeight: FontWeight.bold),
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
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              /*fontFamily: "BlackChancery",*/ color: Colors.black,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text:
                  "Preventing hackers and other online criminals from stealing digital assets comes in two forms: user prevention, and built in prevention.\n\nUser Prevention refers to methods the user should learn and apply in their day to day life to be more secure. When it comes to hacking, it is usually easier to attack the person than it is to attack a computer. This is because people are naturally trusting of others. Social Engineers take advantage of this to extract information. Users should remember to never give out personal information over any form of communication unless 100% sure that it is being given to the correct authorities. Also passwords should never be simple strings as they can easily be guessed, or cracked. Hackers can use dictionaries along with a cracking program to guess a password even if it is made of multiple words. The most secure passwords are at least 7-8 digits and are made of of random strings. In this app there is a ",
            ),
            TextSpan(
                text: "password generator",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        buildContext,
                        new MaterialPageRoute(
                            builder: (context) => new GeneratorScreen()));
                  }),
            TextSpan(
              text:
                  " available, where users can generate secure random passwords, name the passwords, and save the passwords. The saved passwords are secured by biometric authentication",
            ),
            TextSpan(
              text:
                  "(Only the user who owns the phone can access the saved passwords)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  ", and the passwords are stored in the phone using AES encryption",
            ),
            TextSpan(
              text:
                  "(See previous tile for more information regarding encryption)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ".\n\nUsers should also have anti-virus software installed"),
            TextSpan(
              text: "- if not already-",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    " on their computers to prevent malware attacks. For users that work with important data, always monitor the ports"),
            TextSpan(
              text: "(usb, headphone-jack, ethernet)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    " to make sure that there are no unknown devices plugged in. Often hackers may try to infiltrate a work environment and plug in an almost invisible key logger device into a computer."),
          ],
        ),
      ))
];
