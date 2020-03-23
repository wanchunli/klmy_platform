import 'dart:async';

import 'package:flutter/material.dart';

class MyDialog extends Dialog {
  _showTimer(context) {
    var timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      Navigator.pop(context);
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _showTimer(context);
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      child: Text(
                        '关于我们',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: Text('我们是最好的'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
