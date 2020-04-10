import 'package:flutter/material.dart';
import 'package:klmyplatform/bean/TravelBean.dart';
import 'package:klmyplatform/pages/meter/detail_page.dart';

class WidgetPage1 extends StatefulWidget {
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<WidgetPage1> {
  double _height = 50;
  Color _color = Colors.red;
  double _radius = 2;

  double _opacity = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: _changeValue,
            ),
          )
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: _height,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            onEnd: _changeValue,
        ),
//          onEnd: _changeValue,
        ),
      ),
    );
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return null;
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List movies = snapshot.data['subjects'];
    return ListView.builder(
      itemBuilder: (context, index) => _itemBuilder(context, index, movies),
      itemCount: movies.length * 2,
    );
  }

  Widget _itemBuilder(BuildContext context, int index, movies) {
    if (index.isOdd) {
      return Divider();
    }
    index = index ~/ 2;
    return ListTile(
      title: Text(movies[index]['title']),
      leading: Text(movies[index]['year']),
      trailing: Text(movies[index]['original_title']),
    );
  }

  _changeValue() {
    setState(() {
      _height = _height == 50 ? 300 : 50;
      _color = _color == Colors.red ? Colors.blue : Colors.red;
      _radius = _radius == 2 ? 150 : 2;
      _opacity = _opacity == 0.1 ? 1 : 0.1;
    });
  }
}
