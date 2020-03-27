import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:klmyplatform/bean/TravelBean.dart';
import 'package:klmyplatform/components/MyDialog.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Swiper(
                    loop: true,
                    autoplayDelay: 3000,
                    duration: 1000,
                    autoplay: true,
                    itemBuilder: (context, index) {
                      return new Image.network(
                        imageList[index]['url'],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: imageList.length,
                    viewportFraction: 0.8,
                    scale: 0.95,
                    onTap: (index) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MyDialog();
                          });
                    },
                  ),
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
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
                onTap: (){
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
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                Navigator.pushNamed(context, '/camera');
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
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, '/detail');
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
    );
  }
}
