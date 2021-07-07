import 'package:url_launcher/url_launcher.dart';

class News {
  final String _title;
  final String _url;
  final String _author;
  final int _hours;
  final String _timeFrom;
  News(this._title, this._url, this._author, this._hours, this._timeFrom);

  String get title {
    return _title;
  }

  String get url {
    return _url;
  }

  String get author {
    return _author;
  }

  int get hours {
    return _hours;
  }

  String get timeFrom {
    return _timeFrom;
  }

  void launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
