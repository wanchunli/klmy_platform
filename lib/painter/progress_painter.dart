import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klmyplatform/bean/Progress.dart';

class ProgressPainter extends CustomPainter {
  Progress _progress;
  Paint _paint;
  Paint _arrowPaint; //箭头的画笔
  Path _arrowPath; //箭头的路径
  double _outRadius; //半径
  double _inRadius; //半径
  double mAnimTime; //动画时间

  ProgressPainter(
    this._progress,
  ) {
    _arrowPath = Path();
    _arrowPaint = Paint();
    _paint = Paint();
    _outRadius = _progress.outRadius - _progress.strokeWidth / 2;
    _inRadius = _progress.inRadius - _progress.strokeWidth / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    canvas.translate(_progress.strokeWidth / 2, _progress.strokeWidth / 2);

    drawOutProgress(canvas);
    drawInProgress(canvas);
    drawArrow(canvas);
    drawDot(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  drawOutProgress(Canvas canvas) {
    canvas.save();
    _paint //背景
      ..style = PaintingStyle.stroke
      ..color = _progress.backgroundColor
      ..strokeWidth = _progress.strokeWidth;
    canvas.drawCircle(Offset(_outRadius, _outRadius), _outRadius, _paint);

    _paint //进度
      ..color = _progress.color
      ..strokeWidth = _progress.strokeWidth * 1.2
      ..strokeCap = StrokeCap.round;
    double sweepAngle = _progress.outProgress * 360; //完成角度
    print(sweepAngle);
    canvas.drawArc(Rect.fromLTRB(0, 0, _outRadius * 2, _outRadius * 2),
        -90 / 180 * pi, sweepAngle / 180 * pi, false, _paint);
    canvas.restore();
  }

  drawInProgress(Canvas canvas) {
    canvas.save();
    _paint //背景
      ..style = PaintingStyle.stroke
      ..color = _progress.backgroundColor
      ..strokeWidth = _progress.strokeWidth;
    canvas.drawCircle(Offset(_outRadius, _outRadius), _inRadius, _paint);

    _paint //进度
      ..color = _progress.color
      ..strokeWidth = _progress.strokeWidth * 1.2
      ..strokeCap = StrokeCap.round;
    double sweepAngle = _progress.inProgress * 360; //完成角度
    print(sweepAngle);
    canvas.drawArc(Rect.fromLTRB(10, 10, _inRadius * 2 + 10, _inRadius * 2 + 10),
        -90 / 180 * pi, sweepAngle / 180 * pi, false, _paint);
    canvas.restore();
  }

  drawArrow(Canvas canvas) {
    canvas.save();
    canvas.translate(_outRadius, _outRadius); // 将画板移到中心
    canvas.rotate((180 + _progress.outProgress * 360) / 180 * pi); //旋转相应角度
    var half = _inRadius / 2; //基点
    var eg = _inRadius / 50; //单位长
    _arrowPath.moveTo(0, -half - eg * 2);
    _arrowPath.relativeLineTo(eg * 2, eg * 6);
    _arrowPath.lineTo(0, -half + eg * 2);
    _arrowPath.lineTo(0, -half - eg * 2);
    _arrowPath.relativeLineTo(-eg * 2, eg * 6);
    _arrowPath.lineTo(0, -half + eg * 2);
    _arrowPath.lineTo(0, -half - eg * 2);
    canvas.drawPath(_arrowPath, _arrowPaint);
    canvas.restore();
  }

  void drawDot(Canvas canvas) {
    canvas.save();
    int num = _progress.dotCount;
    canvas.translate(_outRadius, _outRadius);
    for (double i = 0; i < num; i++) {
      canvas.save();
      double deg = 360 / num * i;
      canvas.rotate(deg / 180 * pi);
      _paint
        ..strokeWidth = _progress.strokeWidth / 2
        ..color = _progress.backgroundColor
        ..strokeCap = StrokeCap.round;
      if (i * (360 / num) <= _progress.outProgress * 360) {
        _paint..color = _progress.color;
      }
      canvas.drawLine(
          Offset(0, _inRadius * 3 / 4), Offset(0, _inRadius * 4 / 5), _paint);
      canvas.restore();
    }
    canvas.restore();
  }
}
