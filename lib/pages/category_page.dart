import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Image.network(
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583728835301&di=055916457959d63304e6d790c2bd9426&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F61a27c1c59ed0522fa2de91bb0f5ed1122d72c12dc8d-u0DajF_fw658",
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment(0, -1),
              child: Text(
                "冲！冲！冲！",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: Text(
                "我去前面探探路！",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      )
    );
  }
}
