import 'package:flutter/cupertino.dart';

class Token with ChangeNotifier{
  String token;
  String linkPhone;
  String userName;
  int userId;

  Token({this.token, this.linkPhone, this.userName, this.userId});

  void update(Token token) {
    this.token = token.token;
    this.linkPhone = token.linkPhone;
    this.userName = token.userName;
    this.userId = token.userId;
    notifyListeners();
  }
}
