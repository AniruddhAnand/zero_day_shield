import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../values/values.dart';
import '../widget/news.dart';
import 'package:dart_rss/dart_rss.dart';
import '../widget/text_card.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = "/news-screen";
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> _newsListings = [];
  List<String> websites = [
    "https://www.wired.com/feed/category/security/latest/rss",
    "https://feeds.feedburner.com/TheHackersNews",
  ];
  Future<void> _news() async {
    try {
      List<News> newList = [];
      final client = http.Client();
      client
          .get(Uri.parse("https://feeds.feedburner.com/TheHackersNews"))
          .then((response) {
        return response.body;
      }).then((bodyString) {
        final channel = RssFeed.parse(bodyString);
        for (int i = 0; i < channel.items.length; i++) {
          newList.add(News(channel.items[i].title, channel.items[i].link,
              channel.items[i].author));
            print(channe)
        }
        if (mounted) {
          setState(() {
            _newsListings = newList;
          });
        }
        return channel;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    _news();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          title: Text(
            "Cyber Security News",
            style: Styles.customTitleTextStyle(
              color: AppColors.headingText,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.TEXT_SIZE_22,
            ),
          ),
        ),
        body: _newsListings.length > 0
            ? SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: _news,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index >= _newsListings.length) {
                            return null;
                          }
                          return TextCard(
                            onTap: () {
                              _newsListings[index].launchURL();
                            },
                            cardTitle: _newsListings[index].title,
                            description: _newsListings[index].author == null
                                ? "No author"
                                : _newsListings[index].author,
                            color: index % 2 == 0 ? false : true,
                          );
                        }),
                      ),
                    ],
                  ),
              )
            : Center(
                child: CupertinoActivityIndicator(
                radius: 40,
              )));
  }
}
