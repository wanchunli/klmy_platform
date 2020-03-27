import 'package:flutter/material.dart';
import 'package:klmyplatform/bean/Progress.dart';
import 'package:klmyplatform/painter/progress_painter.dart';

class CircleProgressWidget extends StatefulWidget {
  final Progress progress;

  CircleProgressWidget({Key key, this.progress}) : super(key: key);

  @override
  _CircleProgressWidgetState createState() => _CircleProgressWidgetState();
}

class _CircleProgressWidgetState extends State<CircleProgressWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> animate;

  double outValue;
  double inValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    outValue = widget.progress.outProgress;
    inValue = widget.progress.inProgress;
    _controller = AnimationController(
        vsync: this, //
        lowerBound: 0.0,

        ///初始值
        upperBound: 1.0,

        ///结束值
        duration: Duration(seconds: 3));
    _controller
      ..addStatusListener((anim) {})
      ..addListener(() {
        setState(() {
          widget.progress.setProgress(
              outValue * _controller.value, inValue * _controller.value);
        });
      });
    ColorTween color = ColorTween(begin: Colors.blue, end: Colors.red);
    animate = color.animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.progress
        .setProgress(outValue * _controller.value, inValue * _controller.value);
    var progress = Container(
      width: widget.progress.outRadius * 2,
      height: widget.progress.outRadius * 2,
      child: CustomPaint(
        painter: ProgressPainter(widget.progress),
      ),
    );
    String txt = "${(100 * widget.progress.outProgress).toStringAsFixed(1)} %";
    var text = Text(
//      widget.progress.value == 1.0 ? widget.progress.completeText : txt,
      txt,
      style: widget.progress.style ??
          TextStyle(fontSize: widget.progress.outRadius / 6),
    );
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[progress, text],
    );
  }
}
