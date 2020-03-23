import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klmyplatform/config/color.dart';
import 'package:klmyplatform/config/router.dart';
import 'package:klmyplatform/config/string.dart';

import 'index_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      title: KString.mainTitle,
      //商城
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: KColor.primaryColor,
      ),
      home: Scaffold(
        body: IndexPage(),
      ),
    );
  }
}
