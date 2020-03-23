import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  _CartState createState() => _CartState();
}

class _CartState extends State {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _getData(context, index);
        });
  }

  Widget _getData(context, index) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      clipBehavior: Clip.antiAlias,
      semanticContainer: false,
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero),
              child: Image.network(
                "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=179921705,932197673&fm=26&gp=0.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Fluttertoast.showToast(
                  msg: "哈喽！我点击你",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 18,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 2,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black);
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=179921705,932197673&fm=26&gp=0.jpg"),
            ),
            title: Text(
              "Candy shop",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              "Flutter is Google's mobile UI framework for crafting hight",
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
