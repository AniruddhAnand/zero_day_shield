class Password {
  final String _password;
  final String _date;
  final String _name;
  final String _id;
  Password(this._password, this._date, this._name, this._id);
  String get password {
    return _password;
  }

  String get date {
    return _date;
  }

  String get name {
    return _name;
  }

  String get id {
    return _id;
  }
}
