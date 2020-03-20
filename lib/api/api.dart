import 'dart:convert' as json;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klmyplatform/bean/token.dart';

class Api {
  static String host_all = "http://218.17.45.99:11693";
  static String head_url = host_all + "/api";

  Map<String, String> map = {
    'Gddx-Access-AppId': 'android',
    'Gddx-Access-Token': '',
  };

  //登陆接口
//  String LOGIN_TOKEN = head_url + "/auth/dxbase/login";
  String LOGIN_TOKEN = "https://www.baidu.com";

  Future<Token> getData() async{
    var response = await http.get(LOGIN_TOKEN);
    print("状态码：${response.statusCode},body:${response.body}");
    return new Token();
  }

//  http://218.17.45.99:11693/api/auth/dxbase/login
  Future<Token> login(Map map) async {
    var jsonData = json.jsonEncode(map);
    print("接口地址：${LOGIN_TOKEN},JSON数据：${jsonData}");
    var response = await http
        .post(LOGIN_TOKEN,
            headers: {
              'Gddx-Access-AppId': 'android',
              'Gddx-Access-Token': '',
            },
            body: jsonData,
            encoding: Utf8Codec())
        .catchError((error) {
      print('$error错误');
    });
    if (response.statusCode == 200) {
      print("状态码：${response.statusCode},body:${response.body}");
      var map = json.jsonDecode(response.body);
//      if (map['code'] == 0) {
//        return new Token(
//            token: map['token'],
//            linkPhone: map['linkPhone'],
//            userId: map['userId'],
//            userName: map['userName']);
//      } else {
//        print("错误码：${map['code']}");
//      }
    } else {
      print("错误码：${response.statusCode}");
    }
  }
}
