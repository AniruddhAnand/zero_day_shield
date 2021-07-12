import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import '../values/data.dart';
import '../values/values.dart';
import 'package:just_audio/just_audio.dart';

class VoicemailScreen extends StatefulWidget {
  @override
  _VoicemailScreenState createState() => _VoicemailScreenState();
}

class _VoicemailScreenState extends State<VoicemailScreen> {
  List<bool> _play = [false, false, false];
  AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget _success = RichText(
    text: TextSpan(
        style: Styles.customTitleTextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          fontSize: Sizes.TEXT_SIZE_22,
        ),
        children: [
          TextSpan(text: "Congratulations. You have evaded the scammer"),
        ]),
  );
  Widget _failed = RichText(
    textDirection: TextDirection.ltr,
    text: TextSpan(
        style: Styles.customTitleTextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          fontSize: Sizes.TEXT_SIZE_22,
        ),
        children: [
          TextSpan(text: "OOPS! You got scammed"),
        ]),
  );
  Widget _current = Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'IRS Scam',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(ImagePath.voicemail),
              ),
              ListTile(
                title: Text(
                  "IRS 1\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("phone"),
                trailing: _play[0]
                    ? IconButton(
                        icon: Icon(
                          CupertinoIcons.pause,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _play[0] = false;
                          });
                          player.pause();
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          CupertinoIcons.play_fill,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          setState(() {
                            _play[0] = true;
                          });
                          await player.setAsset(recording[0]);
                          player.play();
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: MediaQuery.of(context).size.width < 375
                          ? EdgeInsets.only(left: 45, right: 45)
                          : CupertinoButton(
                              onPressed: () {},
                              child: Text(""),
                            ).padding,
                      color: Colors.lightBlue[900],
                      onPressed: () {
                        setState(() {
                          _current = _failed;
                        });
                      },
                      child: Text(
                        "Respond",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 390
                                ? 14
                                : MediaQuery.of(context).size.width > 200
                                    ? 12
                                    : 10),
                      ),
                    ),
                    CupertinoButton(
                      padding: MediaQuery.of(context).size.width < 375
                          ? EdgeInsets.only(left: 45, right: 45)
                          : CupertinoButton(
                              onPressed: () {},
                              child: Text(""),
                            ).padding,
                      color: Color.fromRGBO(202, 79, 64, 1),
                      onPressed: () {
                        setState(() {
                          _current = _success;
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 390
                                ? 14
                                : MediaQuery.of(context).size.width > 200
                                    ? 12
                                    : 10),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _current,
              )
            ],
          ),
        ),
      ),
    );
  }
}
