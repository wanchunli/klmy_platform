import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klmyplatform/bean/token.dart';
import 'package:klmyplatform/dialog/loading_dialog.dart';
import 'package:klmyplatform/model/token_model.dart';
import 'package:klmyplatform/pages/main_page.dart';
import 'package:klmyplatform/widget/provider_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  bool isRemember = false;
  String loginname;
  String pass;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: phoneController,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              onChanged: (value) {
                this.loginname = value;
              },
              decoration: InputDecoration(
                hintText: '请输入账号',
                icon: Icon(Icons.account_box),
              ),
            ),
            TextField(
              controller: passController,
              maxLines: 1,
              obscureText: true,
              onChanged: (value) {
                this.pass = value;
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: '请输入密码',
                icon: Icon(Icons.lock),
              ),
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    CheckboxListTile(
//                      value: this.isRemember,
//                      onChanged: (value) {},
//                    ),
//                    Text(
//                      "记住密码",
//                      style: TextStyle(color: Colors.grey, fontSize: 16),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    Icon(Icons.settings),
//                    Text(
//                      "设置",
//                      style: TextStyle(color: Colors.grey, fontSize: 16),
//                    ),
//                  ],
//                ),
//              ],
//            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: ProviderWidget<TokenModel>(
                // ignore: missing_return
                builder: (context, model, child) {
                  return RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      '登陆',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    onPressed: () async {

                      _showLoadingDialog(title: "正在登陆...");
                      Token token = await model.login(loginname, pass);
                      if (token != null) {
                        Token pre = Provider.of<Token>(context, listen: false);
                        pre.update(token);
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MainPage()));
                      }
                    },
                  );
                },
                model: TokenModel(Provider.of(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog({String title = "正在加载中..."}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: title,
          );
        });
  }
}
