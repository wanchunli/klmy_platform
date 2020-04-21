import 'package:flutter/material.dart';
import 'package:klmyplatform/bean/bean_video.dart';
import 'package:klmyplatform/pages/video/video_pager.dart';

class CategoryPage extends StatefulWidget {
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State with SingleTickerProviderStateMixin {
  List<String> tabTextList = ['关注', '推荐'];
  List<Tab> tabWidgetList = [];
  List<VideoBean> videoFollowList = [];
  List<VideoBean> videoRecommendList = [];

  TabController tabController;
  PageController _pageController;


  @override
  void initState() {
    _pageController = PageController(
      keepPage: true
    );
    for (var value in tabTextList) {
      tabWidgetList.add(new Tab(
        text: value,
      ));
    }
    tabController = TabController(
      length: tabTextList.length,
      vsync: this,
    );
    for (int i = 0; i < 10; i++) {
      VideoBean videoBean = new VideoBean();
      videoBean.videoName = '记录美好生活';

      if (i % 3 == 0) {
        videoBean.isAttention = true;
        videoBean.isLike = true;
      } else {
        videoBean.isAttention = false;
        videoBean.isLike = false;
      }
      videoBean.likeCount = 3250;
      videoBean.commentCount = 1150;
      videoBean.shareCount = 500;
      videoBean.videoUrl ='';
//      videoBean.videoUrl = 'http://pic.studyyoun.com/MaterialApp%E7%BB%84%E4%BB%B6%E7%9A%84%E5%9F%BA%E6%9C%AC%E4%BD%BF%E7%94%A8.mp4';
      videoFollowList.add(videoBean);
      videoRecommendList.add(videoBean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: buildTabBarView(),
          ),
          Positioned(
            top: 20,
            bottom: 0,
            left: 0,
            right: 0,
            child: buildTabBar(),
          ),
        ],
      ),
    );
  }

  Widget buildTabBarView() {
    return TabBarView(
      controller: tabController,
      children:
          tabTextList.map((value) => buildTabViewItemWidget(value)).toList(),
    );
  }

  buildTabBar() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        tabs: tabWidgetList,
        controller: tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 2.0,
        isScrollable: true,
        labelStyle: TextStyle(
          fontSize: 16
        ),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (index) {},
      ),
    );
  }

  Widget buildTabViewItemWidget(String value) {
    List<VideoBean> videoList = [];
    if (value == '关注') {
      videoList = videoFollowList;
    } else {
      videoList = videoRecommendList;
    }
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        VideoBean videoBean = videoList[index];
        return VideoItemPager(value, videoBean);
      },
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: videoList.length,
    );
  }
}
