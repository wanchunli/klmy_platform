import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klmyplatform/widget/slide_menu.dart';
import 'package:klmyplatform/widget/slide_menu_item.dart';

class CategoryPage extends StatefulWidget {
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State {
  List list = List.generate(Random().nextInt(20) + 10, (i) => 'More Item$i');
  Offset tapDownOffset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Fluttertoast.showToast(msg: '添加');
            },
          ),
        ],
      ),
      body: Center(
        child: ReorderableListView(

          children: list
              .map((m) => Card(
            key: ObjectKey(m),
            margin: EdgeInsets.all(8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            clipBehavior: Clip.antiAlias,
            semanticContainer: false,
              child: Listener(
                  onPointerDown: (downEvent){
                    setState(() {
                      tapDownOffset = downEvent.position;
                    });
                  },
                  child:AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero),
                      child: Container(
                        child: Text(m),
                      ),
                    ),
                  ),
              ),
          ))
              .toList(), //不要忘记 .toList()
          onReorder: _onReorder,
        ),
      ),
//      body: SlideMenu(
//        itemCount: 1000,
//        builder: (context, index) {
//          if (index % 2 == 0) {
//            return Divider(
//              height: 1,
//            );
//          }
//          return SlideMenuItem(
//            menuWidth: 150,
//            child: GestureDetector(
//              onTap: () {
//                print("这是${index}个");
//              },
//              child: ListTile(
//                title: Center(
//                  child: Text("这是第${index}个"),
//                ),
//              ),
//            ),
//            menus: <Widget>[
//              GestureDetector(
//                onTap: () {
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                    content: Text("删除被点击"),
//                    duration: Duration(seconds: 1),
//                  ));
//                },
//                child: Container(
//                  width: 75,
//                  decoration: BoxDecoration(color: Colors.grey),
//                  child: (Center(
//                    child: Text("删除"),
//                  )),
//                ),
//              ),
//              GestureDetector(
//                onTap: () {
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                      content: Text("置顶被点击"), duration: Duration(seconds: 1)));
//                },
//                child: Container(
//                  width: 75,
//                  decoration: BoxDecoration(color: Colors.red),
//                  child: (Center(
//                    child: Text("置顶"),
//                  )),
//                ),
//              )
//            ],
//          );
//        },
//      ),
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      if (newIndex == list.length) {
        newIndex = list.length - 1;
      }
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }
}
