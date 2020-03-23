import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MemberPage extends StatefulWidget {
  _MemberState createState() => _MemberState();
}

class _MemberState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          MyButton("Login"),
          MyButton("C++"),
          MyButton("Python"),
          MyButton("Android Android"),
          MyButton("Flutter Flutter"),
          MyButton("Sqlite"),
          MyButton("UI"),
          MyButton("PHP"),
          MyButton("C#"),
          MyButton("Object-C"),
          MyButton("Swift"),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;

  const MyButton(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.text),
      textColor: Theme.of(context).accentColor,
      onPressed: () {
        Fluttertoast.showToast(
            msg: this.text,
            toastLength: Toast.LENGTH_LONG,
            fontSize: 18,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        if (this.text == "Login") {
          Navigator.pushNamed(context, '/login');
        } else {
          Navigator.pushNamed(context, '/tabbarcontroller');
        }
      },
    );
  }
}
