import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klmyplatform/config/string.dart';
import 'package:klmyplatform/model/index_model.dart';
import 'package:klmyplatform/pages/scaffold_page.dart';
import 'package:klmyplatform/widget/provider_widget.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(KString.homeTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text(KString.categoryTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text(KString.shoppingCarTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text(KString.memberTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps), title: Text(KString.scaffoldTitle)),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
    ScaffoldPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return ProviderWidget<IndexModel>(
      model: IndexModel(),
      builder: (context, model, child) {
        int currentIndex =
            Provider.of<IndexModel>(context, listen: false).index;
        return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            floatingActionButton: Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(top: 10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  model.setIndex(2);
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottomTabs,
              onTap: (index) {
                if (index != 2) {
                  model.setIndex(index);
                }
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: tabBodies,
            ));
      },
    );
  }
}
