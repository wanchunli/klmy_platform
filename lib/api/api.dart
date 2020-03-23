import 'dart:convert' as json;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:klmyplatform/bean/token.dart';

class Api {
  static String host_all = "http://218.17.45.99:11693";

//  static String host_all = "http://218.17.45.99:8850";
  static String head_url = host_all + "/api";

  Map map = {
    'Gddx-Access-AppId': 'android',
    'Gddx-Access-Token': '',
  };

  //登陆接口
  String LOGIN_TOKEN = head_url + "/auth/dxbase/login";

//  String LOGIN_TOKEN = head_url + "/auth/jwt/token";

  Future<Token> getData() async {
    var response = await http.get(LOGIN_TOKEN);
    print("状态码：${response.statusCode},body:${response.body}");
    return new Token();
  }

//  http://218.17.45.99:11693/api/auth/dxbase/login
  Future<Token> login(Map map) async {
    var jsonData = json.jsonEncode(map);
    var backResult;
    var response = await http
        .post(
      LOGIN_TOKEN,
      headers: {
        'Gddx-Access-AppId': 'android',
        'Gddx-Access-Token': '',
        'content-type': 'application/json'
      },
      body: jsonData,
    )
        .catchError((error) {
      print('$error错误');
      return null;
    });
    Utf8Decoder utf8decoder = Utf8Decoder();
    backResult = json.jsonDecode(utf8decoder.convert(response.bodyBytes));
    print('response back:${backResult}');
    if (response.statusCode == 200) {
      Map data = backResult['data'];
      int code = backResult['code'];
      String message = backResult['message'];
      // ignore: unrelated_type_equality_checks
      if (code == 0 && data != null) {
        Fluttertoast.showToast(msg: '登陆成功！');
        return new Token(
            linkPhone: data['linkPhone'],
            userName: data['userName'],
            userId: data['userId'],
            token: data['token']);
      } else {
        Fluttertoast.showToast(msg: message);
        return null;
      }
    } else {
      print('数据请求错误：${response.statusCode}');
      Fluttertoast.showToast(msg: backResult['message']);
      return null;
    }
  }
}
