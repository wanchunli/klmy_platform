import 'package:flutter/material.dart';

class Progress {
  double outProgress;
  double inProgress;
  Color color;
  Color backgroundColor;
  double outRadius;
  double inRadius;
  double strokeWidth;
  int dotCount;
  TextStyle style;
  String completeText;

  Progress(
      {this.outProgress,
      this.inProgress,
      this.color,
      this.backgroundColor,
      this.outRadius,
      this.inRadius,
      this.strokeWidth,
      this.completeText = "OK",
      this.style,
      this.dotCount = 80});

  void setProgress(double outProgress,double inProgress) {
    this.outProgress = outProgress;
    this.inProgress = inProgress;
  }
}
