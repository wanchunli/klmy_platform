import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:klmyplatform/bean/TravelBean.dart';
import 'package:klmyplatform/components/MyDialog.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:klmyplatform/widget/my_header_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  List<Map> imageList = [
    {
      'url':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584420009344&di=fd62e2beee4815dfe76a826f48ad6d5d&imgtype=0&src=http%3A%2F%2Fac-r.static.booking.cn%2Fimages%2Fhotel%2Fmax1024x768%2F175%2F17552265.jpg',
    },
    {
      'url':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584420009343&di=44e66f00b6ec0815eb9d4228a3b1a2f1&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff7d4b8e5093aff7691a66baf5d8693b8e8dc0f681b767-L4ZMb0_fw658'
    },
    {
      'url':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584420323809&di=13306b1372e3006209c0bbe6577a2629&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd009b3de9c82d1582442d267820a19d8bd3e4220.jpg'
    },
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 14,
                      child: Image.asset(
                          'assets/images/2.0x/home_search_icon.png',
                          fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '大家正在搜：红烧肉的做法',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              child: Container(
                child: Icon(
                  Icons.add,
                  size: 22,
                ),
                padding: EdgeInsets.all(3),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: MyHeaderWidget(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Swiper(
                          loop: true,
                          autoplayDelay: 3000,
                          duration: 1000,
                          autoplay: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  imageList[index]['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          itemCount: imageList.length,
                          onTap: (index) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MyDialog();
                                });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        child: Container(
                          height: 195,
                          color: Colors.deepOrange,
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: Center(
                            child: Text(
                              "抄表",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/meterread');
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                          height: 195,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        child: Container(
                                          color: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              "相机",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/camera');
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          color: Colors.deepPurpleAccent,
                                          child: Center(
                                            child: Text(
                                              "动效",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/detail');
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Widget headerView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('- 学名厨做菜，用香哈 -',style: TextStyle(color: Colors.grey[400]),),
          Icon(
            Icons.arrow_downward,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}


