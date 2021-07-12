import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    "https://feeds.feedburner.com/TheHackersNews",
    "https://threatpost.com/feed/"
  ];
  Future<void> _news() async {
    try {
      List<News> newList = [];
      final client = http.Client();
      for (var x in websites) {
        client.get(Uri.parse(x)).then((response) {
          return response.body;
        }).then((bodyString) {
          final channel = RssFeed.parse(bodyString);
          for (int i = 0; i < channel.items.length; i++) {
            DateTime posted = DateFormat("EEE, d MMM yyyy HH:mm:ss Z")
                .parse(channel.items[i].pubDate);
            int difference = DateTime.now().difference(posted).inHours;
            String timeFrom =
                "${difference > 24 ? (difference + .5) ~/ 24 : difference} ${difference > 24 ? (difference + .5) ~/ 24 == 1 ? "day" : "days" : difference == 1 ? "hour" : "hours"}";
            newList.add(News(channel.items[i].title, channel.items[i].link,
                channel.items[i].author, difference, timeFrom));
                print(channel.items[i].dc.creator);
          }
          if (mounted) {
            setState(() {
              _newsListings = newList;
              _newsListings.sort((a, b) => a.hours.compareTo(b.hours));
            });
          }
          return channel;
        });
      }
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
        //backgroundColor: ThemeData.light().canvasColor,
        appBar: AppBar(
          elevation: 5.0,
          title: Text(
            "News",
            style: Styles.customTitleTextStyle(
              color: AppColors.headingText,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.TEXT_SIZE_22,
            ),
          ),
        ),
        body: _newsListings.length > 0
            ? SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Latest Cyber Security News",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          CupertinoSliverRefreshControl(
                            onRefresh: _news,
                          ),
                          SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              if (index >= _newsListings.length) {
                                return null;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextCard(
                                  onTap: () {
                                    _newsListings[index].launchURL();
                                  },
                                  cardTitle: _newsListings[index].title,
                                  description:
                                      _newsListings[index].author == null
                                          ? "No author"
                                          : _newsListings[index].author,
                                  color: index % 2 == 0 ? false : true,
                                  time: _newsListings[index].timeFrom,
                                  cardHeight:
                                      MediaQuery.of(context).size.height < 677
                                          ? 160
                                          : 150.0,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
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
