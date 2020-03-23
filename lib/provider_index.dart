import 'package:klmyplatform/bean/token.dart';
import 'package:klmyplatform/model/index_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'api/api.dart';

List<SingleChildStatelessWidget> providers = [
  Provider<Api>(
    create: (_) => Api(),
  ),
  ChangeNotifierProvider<Token>(
//    create: (_) => Token(),
    create: (_) => Token(),
  ),
  ChangeNotifierProvider<IndexModel>(
    create: (_) => IndexModel(),
  ),
];
