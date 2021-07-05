import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import '../helper/db_helper.dart';
import '../values/values.dart';
import '../widget/password.dart';
import "../widget/s"

class ScrollScreen extends StatefulWidget {
  static const routeName = "/scroll-screen";
  List<Password> _list;
  ScrollScreen(this._list);

  @override
  _ScrollScreenState createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
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
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("DELETE",
                              style: TextStyle(
                                color: Colors.red,
                              ))),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "CANCEL",
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
            child: ListTile(
              title: Text(item.password),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Date:${item.date}")
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    FlutterClipboard.copy(item.password)
                        .then((value) => print('copied'));
                  }),
            ),
          );
        },
        itemCount: widget._list.length,
      ),
    );
  }
}
