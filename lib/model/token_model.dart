import 'package:klmyplatform/api/api.dart';
import 'package:klmyplatform/bean/token.dart';
import 'package:klmyplatform/device/platform.dart';
import 'package:klmyplatform/model/base_model.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenModel extends BaseModel {
  Api _api;

  // ignore: non_constant_identifier_names
  TokenModel(Api api) {
    this._api = api;
  }

  Future<Token> login(String loginname, String pass) async {
    loadingg(true);
    Map map = {};
    map.putIfAbsent("loginName", () => loginname);
    map.putIfAbsent("loginPassword", () => generateMd5(pass));
    var platformInfo = new PlatformInfo();
    var info = await platformInfo.initPlatformState();

    map.putIfAbsent("deviceImei", () => '867175039606571');
    map.putIfAbsent("deviceName", () => 'HUAWEI');
    map.putIfAbsent("deviceToken", () => '867175039606571');
    map.putIfAbsent("deviceType", () => 'VTR-AL00');
    map.putIfAbsent("deviceVer", () => '9');
    map.putIfAbsent("loginType", () => 'PWD');
    map.putIfAbsent("loginAddress", () => '广东省深圳市宝安区塘和三路26号靠近塘头第三工业区');
    map.putIfAbsent("latitude", () => 22.65352);
    map.putIfAbsent("longitude", () => 113.907726);
    Token token = await _api.login(map);
    if (token != null) {
      _saveToken(token);
    }
    loadingg(false);
    return token;
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  void _saveToken(Token token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("token", token.token);
    prefs.setInt("userId", token.userId);
    prefs.setString("linkPhone", token.linkPhone);
    prefs.setString("userName", token.userName);
  }
}
