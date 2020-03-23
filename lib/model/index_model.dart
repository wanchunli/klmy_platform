import 'package:klmyplatform/model/base_model.dart';

class IndexModel extends BaseModel {
  int index = 0;

  void setIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}
