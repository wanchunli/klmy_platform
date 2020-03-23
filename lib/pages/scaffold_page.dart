import 'package:flutter/material.dart';

class ScaffoldPage extends StatefulWidget {
  _ScaffoldState createState() => _ScaffoldState();
}

class _ScaffoldState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text(
            "设置",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//            return SettingPage(
//              title: "我是设置传值",
//            );
//          }
            Navigator.pushNamed(context, '/setting', arguments: {
              "title": "我是设置传值"
            });
            Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                builder: (context) => new ScaffoldPage()), (route) =>
            route == null);
          }
      ),);
  }
}



