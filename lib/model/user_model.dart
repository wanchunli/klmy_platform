import 'package:klmyplatform/api/api.dart';
import 'package:klmyplatform/model/base_model.dart';

class UserModel extends BaseModel {
  Api _api;

  UserModel(Api api) {
    this._api = api;
  }

}
