import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/foundation.dart" as Key;
import '../helper/db_helper.dart';
import '../values/values.dart';
import '../widget/password.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as Key2;

class ScrollScreen extends StatefulWidget {
  static const routeName = "/scroll-screen";
  ScrollScreen();

  @override
  _ScrollScreenState createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  List<Password> _pwds = [];
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_pycos');
    setState(() {
      _pwds = dataList.map((item) {
        final encrypted = Encrypted.fromBase64(item["id"]);
        final iv = IV.fromLength(16);
        final encrypter = Encrypter(AES(Key2.Key.fromUtf8(item["key"])));
        final decrypted = encrypter.decrypt(encrypted, iv: iv);
        return Password(decrypted, item["title"], item["name"], item["id"]);
      }).toList();
    });
    _pwds = _pwds.reversed.toList();
  }

  void deleteAll() {
    return CupertinoAlertDialog(
      title: const Text("Confirm"),
      content: const Text("Are you sure you wish to delete this item?"),
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
    _pwds.forEach((item) {
      DBHelper.delete(item.id);
      setState(() {
        _pwds.remove(item);
      });
    });
  }

  bool isSearch = false;
  TextEditingController search = new TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Password Vault",
          style: Styles.customTitleTextStyle(
            color: AppColors.headingText,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.TEXT_SIZE_22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.trash, color: Colors.red),
            onPressed: deleteAll,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          shrinkWrap: true,
          itemBuilder: (ctx, i) {
            final item = _pwds[i];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Dismissible(
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
                key: Key.Key(item.id),
                onDismissed: (direction) {
                  DBHelper.delete(item.id);
                  setState(() {
                    _pwds.removeAt(i);
                  });
                },
                child: ListTile(
                  //tileColor: Color.fromRGBO(242, 241, 246, 1),
                  title: RichText(
                    text: TextSpan(children: getText(item.password)),
                    softWrap: true,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width < 375
                                  ? 12
                                  : 14),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "${item.date}",
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width < 375
                                ? 12
                                : 14),
                      ))
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.copy,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        FlutterClipboard.copy(item.password)
                            .then((value) => print('copied'));
                      }),
                ),
              ),
            );
          },
          itemCount: _pwds.length,
        ),
      ),
    );
  }
}
