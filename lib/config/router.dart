import 'package:flutter/material.dart';
import 'package:klmyplatform/pages/camera/camera_page.dart';
import 'package:klmyplatform/pages/login_page.dart';
import 'package:klmyplatform/pages/meter/detail_page.dart';
import 'package:klmyplatform/pages/meter/home_page.dart';
import 'package:klmyplatform/pages/meter/meter_read_page.dart';

var routes = {
  '/login':(context) => LoginPage(),
  '/meterread':(context) => ReadPage(),
  '/camera':(context) => CameraWidget(),
  '/detail':(context) => HomePage(),
};

//固定写法
// ignore: missing_return, top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
