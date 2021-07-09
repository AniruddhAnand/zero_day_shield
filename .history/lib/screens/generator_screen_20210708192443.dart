import 'package:local_auth/local_auth.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "dart:math";
import 'package:clipboard/clipboard.dart';
import 'expanded_tile.dart';
import '../values/values.dart';
import '../helper/db_helper.dart';
import 'package:intl/intl.dart' as DateFormat;
import '../widget/password.dart';
import 'scroll_screen.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as Key;
import "../values/data.dart";

class GeneratorScreen extends StatefulWidget {
  static const routeName = "/generator-screen";
  static Random _rnd = Random();
  static String getChars(bool lower, bool upper, bool numerical, bool spec) {
    String s = "";
    if (lower) {
      s += "abcdefghijklmnopqrstuvwxyz";
    }
    if (upper) {
      s += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    }
    if (numerical) {
      s += "123456789012345678901234567890";
    }
    if (spec) {
      s += "!@#\$%&*!@#\$%&*!@#\$%&*";
    }
    return s;
  }

  static String getRandomString(
      int length, bool lower, bool upper, bool numerical, bool spec) {
    String chars = getChars(lower, upper, numerical, spec);
    String s = String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_rnd.nextInt(chars.length))));
    if (spec) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(7);
      s = s.substring(0, rndIndex) +
          "!@#\$%&*".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (lower) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(26);
      s = s.substring(0, rndIndex) +
          "abcdefghijklmnopqrstuvwxyz".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (upper) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(26);
      s = s.substring(0, rndIndex) +
          "ABCDEFGHIJKLMNOPQRSTUVWXYZ".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    if (numerical) {
      int rndIndex = new Random().nextInt(s.length);
      int specIndex = new Random().nextInt(10);
      s = s.substring(0, rndIndex) +
          "1234567890".substring(specIndex, specIndex + 1) +
          s.substring(rndIndex + 1);
    }
    return s;
  }

  @override
  _GeneratorScreenState createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  TextEditingController _name = new TextEditingController();
  bool isAuthenticated = false;
  Future<void> authenticate() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    if (canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }
    return isAuthenticated;
  }

  final String description =
      "The general passwords you will use in your day to day life are NOT secure. Most people are prone to using passwords that are related to them, such as a pet's name, or even their own name. Hackers can easily exploit this and gather information from unaware people through simple conversation with social engineering. This password generator creates a random string of characters making it difficult for hackers to get these passwords. The passwords when stored in your phone's data base is encrypted with AES encryption, which prevents hackers from stealing these passwords.";
  bool _az = true;
  bool _captial = true;
  bool _numbers = true;
  bool _special = true;
  var _tempNum = 8.0;
  String _currentPwd = "";
  List<Password> _pwds = [];
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_pycos');
    int len = dataList.length;
    int count = 0;
    setState(() {
      _pwds = dataList.map((item) {
        final encrypted = Encrypted.fromBase64(item["id"]);
        final iv = IV.fromLength(16);
        final encrypter = Encrypter(AES(Key.Key.fromUtf8(item["key"])));
        final decrypted = encrypter.decrypt(encrypted, iv: iv);
        return Password(decrypted, item["title"], item["name"], item["id"]);
      }).toList();
    });
    _pwds = _pwds.reversed.toList();
  }

  List<TextSpan> getText(String s) {
    List<TextSpan> list = [];
    for (int i = 0; i < s.length; i++) {
      if ("1234567890".contains(s.substring(i, i + 1))) {
        list.add(TextSpan(
            text: s.substring(i, i + 1), style: TextStyle(color: Colors.blue)));
      } else if ("!@#\$%&*".contains(s.substring(i, i + 1))) {
        list.add(TextSpan(
            text: s.substring(i, i + 1), style: TextStyle(color: Colors.red)));
      } else {
        list.add(TextSpan(
            text: s.substring(i, i + 1),
            style: TextStyle(color: Colors.black)));
      }
    }
    return list;
  }

  @override
  void initState() {
    fetchAndSetPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Password Generator",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
        actions: [
          CupertinoButton(
            child: Icon(Icons.list_rounded, color: Colors.black),
            onPressed: () async {
              bool isAuthenticated =
                  await Authentication.authenticateWithBiometrics();
              if (isAuthenticated) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new ScrollScreen(_pwds),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _currentPwd.length == 0
                    ? Text(
                        "No Password Generated",
                        style: TextStyle(
                            fontFamily: "TravelingTypewriter",
                            fontSize: width > 390
                                ? 30
                                : width > 200
                                    ? 26
                                    : 23,
                            color: Colors.red),
                      )
                    : RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontFamily: "TravelingTypewriter",
                              fontSize: _currentPwd.length > 40
                                  ? 15
                                  : _currentPwd.length > 30
                                      ? 20
                                      : _currentPwd.length > 24
                                          ? 25
                                          : 30,
                              color: Colors.black,
                            ),
                            children: getText(_currentPwd)),
                      ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Lowercase Letters",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "(abcdefghijklmnopqrstuvwxyz)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.lightBlue[900],
                      onChanged: (x) {
                        setState(() {
                          _az = x;
                        });
                      },
                      value: _az,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Uppercase Letters",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "(ABCDEFGHIJKLMNOPQRSTUVWXYZ)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width < 375
                                ? 12
                                : 15,
                          ),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.lightBlue[900],
                      onChanged: (x) {
                        setState(() {
                          _captial = x;
                        });
                      },
                      value: _captial,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Numbers",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "(0123456789)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.lightBlue[900],
                      onChanged: (x) {
                        setState(() {
                          _numbers = x;
                        });
                      },
                      value: _numbers,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Special Characters",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "(!@#\$%&*)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.lightBlue[900],
                      onChanged: (x) {
                        setState(() {
                          _special = x;
                        });
                      },
                      value: _special,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Number of Characters",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MediaQuery.of(context).size.width < 375 ? 17 : 20,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize:
                              MediaQuery.of(context).size.width < 375 ? 15 : 24,
                          color: Colors.lightBlue[900],
                          icon: Icon(CupertinoIcons.minus_rectangle_fill),
                          onPressed: () {
                            if (_tempNum > 8) {
                              setState(() {
                                _tempNum--;
                              });
                            }
                          },
                        ),
                        Text(
                          "$_tempNum",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width < 375
                                ? 15
                                : 20,
                          ),
                        ),
                        IconButton(
                          iconSize:
                              MediaQuery.of(context).size.width < 375 ? 15 : 24,
                          color: Colors.lightBlue[900],
                          icon: Icon(CupertinoIcons.plus_rectangle_fill),
                          onPressed: () {
                            if (_tempNum < 50) {
                              setState(() {
                                _tempNum++;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: MediaQuery.of(context).size.width < 375
                          ? EdgeInsets.only(left: 45, right: 45)
                          : CupertinoButton(
                              onPressed: () {},
                              child: Text(""),
                            ).padding,
                      child: Text(
                        "Generate",
                        style: TextStyle(
                            fontSize: width > 390
                                ? 14
                                : width > 380
                                    ? 12
                                    : 10),
                      ),
                      color: Colors.lightBlue[900],
                      onPressed: () {
                        setState(() {
                          _currentPwd = GeneratorScreen.getRandomString(
                              _tempNum.toInt(),
                              _az,
                              _captial,
                              _numbers,
                              _special);
                        });
                        if (_currentPwd.length > 0) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text("Save Password"),
                                  content: Card(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          maxLength: 20,
                                          decoration: InputDecoration(
                                              hintText: "Enter a Name"),
                                          controller: _name,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                        isDefaultAction: true,
                                        onPressed: () {
                                          if (_name.text.length > 0 &&
                                              _name.text.length <= 20) {
                                            String k =
                                                GeneratorScreen.getRandomString(
                                                    32,
                                                    true,
                                                    true,
                                                    false,
                                                    false);
                                            final key = Key.Key.fromUtf8(k);
                                            final iv = IV.fromLength(16);
                                            final encrypter =
                                                Encrypter(AES(key));
                                            final encrypted = encrypter
                                                .encrypt(_currentPwd, iv: iv);
                                            DBHelper.insert('user_pycos', {
                                              "id": encrypted.base64,
                                              "title": DateFormat.DateFormat(
                                                      'dd/MM/yyyy hh:mm')
                                                  .format(DateTime.now()),
                                              "key": k,
                                              "name": _name.text
                                            });
                                            fetchAndSetPlaces();
                                            _name.text = "";
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text("Save")),
                                    CupertinoDialogAction(
                                        textStyle: TextStyle(color: Colors.red),
                                        isDefaultAction: true,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel")),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                    CupertinoButton(
                      padding: MediaQuery.of(context).size.width < 375
                          ? EdgeInsets.only(left: 45, right: 45)
                          : CupertinoButton(
                              onPressed: () {},
                              child: Text(""),
                            ).padding,
                      child: Text(
                        "  Copy  ",
                        style: TextStyle(
                            fontSize: width > 390
                                ? 14
                                : width > 380
                                    ? 12
                                    : 10),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        if (_currentPwd.length > 0) {
                          FlutterClipboard.copy(_currentPwd).then((value) {});
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "Most people are prone to using passwords that are related to them, such as a pet's name, or even their own name. Hackers can easily exploit this using ",
                          ),
                          TextSpan(
                            text: "social engineering",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                bool isAuthenticated = await Authentication
                                    .authenticateWithBiometrics();
                                if (isAuthenticated) {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) =>
                                          new ScrollScreen(_pwds),
                                    ),
                                  );
                                }
                              },
                          ),
                          TextSpan(
                              text:
                                  " practices. This password generator creates a random string of characters making it difficult for hackers to guess or extract these passwords. The passwords generated from this app are encrypted with AES encryption in the phone's database."),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Password Vault",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new ExpandedTile(
                                              fullTexts[1],
                                              SizedBox(
                                                child: Image.asset(
                                                  imagePaths[1],
                                                ),
                                              ),
                                              titles[1],
                                            )));
                              },
                          ),
                        ]),
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

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }

    return isAuthenticated;
  }
}
