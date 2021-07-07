import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import '../values/values.dart';

class NigerianScreen extends StatefulWidget {
  @override
  _NigerianScreenState createState() => _NigerianScreenState();
}

class _NigerianScreenState extends State<NigerianScreen> {
  bool _fullText = false;
  Widget _success = RichText(
    textAlign: TextAlign.justify,
    textDirection: TextDirection.ltr,
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
          'Nigerian Scam',
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
              children: [
                SizedBox(
                  child:Image.asset(ImagePath.scammerEmail),
                ),
                _fullText
                    ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.TEXT_SIZE_16,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "I am Dr. Bakare Tunde, the cousin of Nigerian Astronaut, Air Force Major Abacha Tunde. He was the first African in space when he made a secret flight to the Salyut 6 space station in 1979. He was on a later Soviet spaceflight, Soyuz T-16Z to the secret Soviet military space station Salyut 8T in 1989. He was stranded there in 1990 when the Soviet Union was dissolved. His other Soviet crew members returned to earth on the Soyuz T-16Z, but his place was taken up by return cargo. There have been occasional Progrez supply flights to keep him going since that time. He is in good humor, but wants to come home.\n\n"),
                              TextSpan(
                                  text:
                                      "In the 14-years since he has been on the station, he has accumulated flight pay and interest amounting to almost \$ 15,000,000 American Dollars. This is held in a trust at the Lagos National Savings and Trust Association. If we can obtain access to this money, we can place a down payment with the Russian Space Authorities for a Soyuz return flight to bring him back to Earth. I am told this will cost \$ 3,000,000 American Dollars. In order to access the his trust fund we need your assistance.\n\n"),
                              TextSpan(
                                  text:
                                      "Consequently, my colleagues and I are willing to transfer the total amount to your account or subsequent disbursement, since we as civil servants are prohibited by the Code of Conduct Bureau (Civil Service Laws) from opening and/ or operating foreign accounts in our names. Needless to say, the trust reposed on you at this juncture is enormous. In return, we have agreed to offer you 20 percent of the transferred sum, while 10 percent shall be set aside for incidental expenses (internal and external) between the parties in the course of the transaction. You will be mandated to remit the balance 70 percent to other accounts in due course.\n"),
                              TextSpan(
                                text: "Click here to minimize the scenario\n\n",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Sizes.TEXT_SIZE_10,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _fullText = false;
                                    });
                                  },
                              ),
                            ],
                          ),
                        ),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.TEXT_SIZE_16,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Consequently, my colleagues and I are willing to transfer the total amount to your account or subsequent disbursement, since we as civil servants are prohibited by the Code of Conduct Bureau (Civil Service Laws) from opening and/ or operating foreign accounts in our names. Needless to say, the trust reposed on you at this juncture is enormous. In return, we have agreed to offer you 20 percent of the transferred sum, while 10 percent shall be set aside for incidental expenses (internal and external) between the parties in the course of the transaction. You will be mandated to remit the balance 70 percent to other accounts in due course.\n"),
                              TextSpan(
                                text: "Click here to read full scenario\n\n",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Sizes.TEXT_SIZE_10,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _fullText = true;
                                    });
                                  },
                              ),
                            ],
                          ),
                        ),
                    ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        color: Colors.lightBlue[900],
                        onPressed: () {
                          setState(() {
                            _current = _failed;
                          });
                        },
                        child: Text(
                          "Respond",
                          style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width>390?),
                        ),
                      ),
                      CupertinoButton(
                        color: Color.fromRGBO(202,79,64,1),
                        onPressed: () {
                          setState(() {
                            _current = _success;
                          });
                        },
                        child: Text(
                          "Delete ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
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
