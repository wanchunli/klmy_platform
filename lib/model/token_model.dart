import 'package:klmyplatform/api/api.dart';
import 'package:klmyplatform/bean/token.dart';
import 'package:klmyplatform/device/platform.dart';
import 'package:klmyplatform/model/base_model.dart';

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
    map.putIfAbsent("loginPassword", () => pass);
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

//    map.putIfAbsent("deviceImei", () => info['androidId']);
//    map.putIfAbsent("deviceToken", () => info['androidId']);
//    map.putIfAbsent("deviceType", () => '');
//    map.putIfAbsent("deviceName", () => info['brand']);
//    map.putIfAbsent("deviceVer", () => info['brand']);
//    map.putIfAbsent("loginType", () => info['PWD']);
//    map.putIfAbsent("loginAddress", () => info['深圳']);
//    map.putIfAbsent("latitude", () => 0);
//    map.putIfAbsent("longitude", () => 0);

    Token token = await _api.login(map);
//    Token token = await _api.getData();
    loadingg(false);
    return token;
  }
}
