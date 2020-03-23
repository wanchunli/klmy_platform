import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token with ChangeNotifier {
  String token;
  String linkPhone;
  String userName;
  int userId;

  Token({this.token, this.linkPhone, this.userName, this.userId});

  void initShared() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    this.token = prefs.getString('token');
    this.linkPhone = prefs.getString('linkPhone');
    this.userName = prefs.getString('userName');
    this.userId = prefs.getInt('userId');
    print('initShared${token}');
    notifyListeners();
  }

  void update(Token token) {
    this.token = token.token;
    this.linkPhone = token.linkPhone;
    this.userName = token.userName;
    this.userId = token.userId;
    notifyListeners();
  }
}
