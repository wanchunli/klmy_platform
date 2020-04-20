import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klmyplatform/config/color.dart';
import 'package:klmyplatform/config/router.dart';
import 'package:klmyplatform/config/string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      autoLoad: true,
      child: MaterialApp(
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
      ),
    );
  }
}
