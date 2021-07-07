import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import '../helper/db_helper.dart';
import '../values/values.dart';
import '../widget/password.dart';

class ScrollScreen extends StatefulWidget {
  static const routeName = "/scroll-screen";
  List<Password> _list;
  ScrollScreen(this._list);

  @override
  _ScrollScreenState createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Password Viewer",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, i) {
          final item = widget._list[i];
          return Dismissible(
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to delete this item?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete",
                              style: TextStyle(
                                color: Colors.red,
                              ))),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.red),
            key: Key(item.id),
            onDismissed: (direction) {
              DBHelper.delete(item.id);
              setState(() {
                widget._list.removeAt(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                tileColor: Color.fromRGBO(242,241,246,1),
                title: RichText(text:),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(color: Colors.black),
                        softWrap: true,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Text("Date: ${item.date}",softWrap: true,))
                  ],
                ),
                trailing: IconButton(
                    icon: Icon(Icons.copy,color: Colors.blue,),
                    onPressed: () {
                      FlutterClipboard.copy(item.password)
                          .then((value) => print('copied'));
                    }),
              ),
            ),
          );
        },
        itemCount: widget._list.length,
      ),
    );
  }
}
