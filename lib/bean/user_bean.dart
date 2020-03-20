
import 'package:flutter/cupertino.dart';

class Userbean with ChangeNotifier{

   String loginname;
   String name;
   String headImg;
   String analyst;

   Userbean({this.loginname, this.name});

   void update(Userbean userbean){
      this.loginname = userbean.loginname;
      this.name = userbean.name;
   }
}