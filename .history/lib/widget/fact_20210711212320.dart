class Fact {
  String _fact;
  String _url;
  Fact(this._fact,this._url);
  String get fact {
    return _fact;
  }

  String get url {
    return _url;
  }

   void launchURL() async => await can(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
