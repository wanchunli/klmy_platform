import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klmyplatform/bean/bean_video.dart';
import 'package:video_player/video_player.dart';

class VideoItemPager extends StatefulWidget {
  String _tabValue = '';
  VideoBean _videoBean;

  VideoItemPager(String tabValue, VideoBean videoBean) {
    this._tabValue = tabValue;
    this._videoBean = videoBean;
  }

  _VideoItemPager createState() => _VideoItemPager();
}

class _VideoItemPager extends State<VideoItemPager>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  Future videoFuture;

  AnimationController animController;

  @override
  void initState() {
//    _controller = VideoPlayerController.network(widget._videoBean.videoUrl);
    _controller =
        VideoPlayerController.network('http://218.17.45.99:11693/wanchun.mp4');
    _controller.setLooping(true);
    videoFuture = _controller.initialize().then((_) {
      _controller.play();
      setState(() {
        animController.forward();
      });
    });
    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    animController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //重置起点
        animController.reset();
        //开启
        animController.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //视频播放
        _buildVideoWidget(),
        //视频播放控制
        _buildControllerWidget(),
        //视频简介
        _buildBottomInfoWidget(),
        //右侧用户信息按钮
        _buildUserInfoWidget(),
        //底部旋转
        _buildMusicWidget(),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Widget _buildVideoWidget() {
    return FutureBuilder(
      future: videoFuture,
      builder: (BuildContext context, value) {
        if (value.connectionState == ConnectionState.done) {
          return InkWell(
            child: Container(
              alignment: Alignment.center,
              child: VideoPlayer(_controller),
            ),
            onTap: () {
              //判断视频是否已经初始化
              if (_controller.value.initialized) {
                //判断视频是否正在播放
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                setState(() {});
              } else {
                //未初始化
                _controller.initialize().then((_) {
                  _controller.play();
                  setState(() {});
                });
              }
            },
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildControllerWidget() {
    Widget itemWidget;
    if (_controller.value.initialized && !_controller.value.isPlaying) {
      itemWidget = InkWell(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(22))),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
        onTap: () {
          _controller.play();
          setState(() {});
        },
      );
    }

    return Align(
      alignment: Alignment(0, 0),
      child: itemWidget,
    );
  }

  Widget _buildBottomInfoWidget() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '@边牧贝拉',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '#遛狗',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.music_note,
                  size: 14,
                  color: Colors.white,
                ),
                Text(
                  '上班没时间遛狗',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoWidget() {
    return Align(
      alignment: Alignment(1, 0.5),
      child: Container(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //用户信息
            _buildUserItem(),
            //喜欢
            _buildLikeWidget(),
            //评论
            _buildCommentWidget(),
            //转发
            _buildShareWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserItem() {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment(0, 0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=179921705,932197673&fm=26&gp=0.jpg"),
            ),
          ),
          widget._videoBean.isAttention
              ? Container()
              : Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildLikeWidget() {
    bool isLike = widget._videoBean.isLike;
    int itemCount = widget._videoBean.likeCount;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: isLike
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                )
              : Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
          onPressed: () {
            if (isLike) {
              widget._videoBean.isLike = false;
              widget._videoBean.likeCount--;
            } else {
              widget._videoBean.isLike = true;
              widget._videoBean.likeCount++;
            }
            setState(() {});
          },
        ),
        Text(
          '${itemCount}',
          style: TextStyle(color: Colors.white, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildCommentWidget() {
    int itemCount = widget._videoBean.commentCount;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.comment,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        Text(
          '${itemCount}',
          style: TextStyle(color: Colors.white, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildShareWidget() {
    int itemCount = widget._videoBean.shareCount;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        Text(
          '${itemCount}',
          style: TextStyle(color: Colors.white, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildMusicWidget() {
    //旋转
    return Align(
      alignment: Alignment(1, 1),
      child: Container(
        margin: EdgeInsets.all(10),
        child: RotationTransition(
          //设置动画的旋转中心
          alignment: Alignment.center,
          //动画控制器
          turns: animController,
          //将要执行动画的子view
          child: Container(
            width: 44,
            height: 44,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              color: Colors.grey,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=179921705,932197673&fm=26&gp=0.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
