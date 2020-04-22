import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klmyplatform/bean/TravelBean.dart';
import 'package:klmyplatform/components/MyDialog.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:klmyplatform/widget/my_header_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State with SingleTickerProviderStateMixin {
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

  List<Map> funcList = [
    {'img': 'assets/images/2.0x/home_fanc_nav_1.png', 'text': '菜谱分类'},
    {'img': 'assets/images/2.0x/home_fanc_nav_2.png', 'text': '三餐打卡'},
    {'img': 'assets/images/2.0x/home_fanc_nav_3.png', 'text': '本周佳作'},
    {'img': 'assets/images/2.0x/home_fanc_nav_4.png', 'text': '活动'},
    {'img': 'assets/images/2.0x/home_fanc_nav_5.png', 'text': '经期养生'},
    {'img': 'assets/images/2.0x/home_fanc_nav_21.png', 'text': '家常菜'},
    {'img': 'assets/images/2.0x/home_fanc_nav_22.png', 'text': '烘培'},
    {'img': 'assets/images/2.0x/home_fanc_nav_23.png', 'text': '下饭菜'},
    {'img': 'assets/images/2.0x/home_fanc_nav_24.png', 'text': '素菜'},
    {'img': 'assets/images/2.0x/home_fanc_nav_25.png', 'text': '赚积分'},
  ];
  List<String> tabTextList = ['关注', '推荐', '菜谱', '美食圈', '烘培', '小技巧'];
  List<Tab> tabWidgetList = [];
  TabController _tabController;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map> dataList = [
    {
      'name': '爱美食的小猪',
      'header': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'title': '唯有美食不可辜负',
      'img': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'time': '1分钟前',
      'views': 7,
      'isCollection': false,
      'isVip': true,
    },
    {
      'name': '爱美食的小猪',
      'header': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'title': '唯有美食不可辜负',
      'img': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'time': '1分钟前',
      'views': 7,
      'isCollection': false,
      'isVip': true,
    },
    {
      'name': '爱美食的小猪',
      'header': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'title': '唯有美食不可辜负',
      'img': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'time': '1分钟前',
      'views': 7,
      'isCollection': false,
      'isVip': true,
    },
    {
      'name': '爱美食的小猪',
      'header': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'title': '唯有美食不可辜负',
      'img': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'time': '1分钟前',
      'views': 7,
      'isCollection': false,
      'isVip': true,
    },
    {
      'name': '爱美食的小猪',
      'header': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'title': '唯有美食不可辜负',
      'img': 'http://pic.sc.chinaz.com/files/pic/pic9/202004/zzpic24526.jpg',
      'time': '1分钟前',
      'views': 7,
      'isCollection': false,
      'isVip': true,
    },
  ];
  PageController _pageController;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(keepPage: true);
    for (var value in tabTextList) {
      tabWidgetList.add(new Tab(
        text: value,
      ));
    }
    _tabController = TabController(
      length: tabTextList.length,
      vsync: this,
    );
    _scrollController = new ScrollController(
      keepScrollOffset: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
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
              enablePullUp: true,
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
              child: Container(
                child: NestedScrollView(
                  reverse: false,
                  headerSliverBuilder: (context, bool) {
                    return [
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          margin: EdgeInsets.only(top: 10.0),
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
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: <Widget>[
                              GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: funcList.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    //横轴元素个数
                                    crossAxisCount: 5,
                                    //纵轴间距
                                    mainAxisSpacing: 0.0,
                                    //横轴间距
                                    crossAxisSpacing: 5.0,
                                    //子组件宽高长度比例
                                    childAspectRatio: 0.9,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              funcList[index]['img'],
                                              fit: BoxFit.cover,
                                            ),
                                            height: 40,
                                            width: 40,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            funcList[index]['text'],
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: SliverTabBarDelegate(
                          TabBar(
                            tabs: tabWidgetList,
                            controller: _tabController,
                            indicatorColor: Colors.red[300],
                            indicatorWeight: 2.0,
                            isScrollable: true,
                            labelColor: Colors.black87,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                            unselectedLabelStyle: TextStyle(fontSize: 15),
                            indicatorSize: TabBarIndicatorSize.label,
                            onTap: (index) {},
                          ),
                          color: Colors.grey[200],
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  scrollDirection: Axis.vertical,
                  body: TabBarView(
                    controller: _tabController,
                    children: tabTextList
                        .map((value) => buildTabViewItemWidget(value))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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

  Widget buildTabViewItemWidget(String value) {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return buildFollowItem(index);
              }),
        );
      },
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: tabTextList.length,
    );
  }

  Widget buildFollowItem(index) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(dataList[index]['header']),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dataList[index]['name'],
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    Text(
                      dataList[index]['time'],
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  child: Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Container(
                        height: 26,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            border: Border.all(color: Colors.grey[500])),
                      ),
                      Text(
                        '关注',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Fluttertoast.showToast(msg: '关注咯');
                  },
                ),
              ),

            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 5),
            child: Text(dataList[index]['title'],
                style: TextStyle(color: Colors.black87, fontSize: 16)),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  dataList[index]['img'],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child:Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    child: Text('${dataList[index]['views']}浏览',
                        style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                  ),
                  Positioned(
                    right: 0,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 17,
                        ),
                        SizedBox(width: 3,),
                        Text(
                          '收藏',
                          style: TextStyle(color: Colors.grey,fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
