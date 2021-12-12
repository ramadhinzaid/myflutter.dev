import 'package:flutter/material.dart';

@immutable
class CircleConfig {
  final Color borderColor;
  final Color fillColor;
  final double borderWidth;
  final double circleSize;

  const CircleConfig(
      {this.borderColor = Colors.white,
      this.borderWidth = 1,
      this.fillColor = Colors.white,
      this.circleSize = 20});
}

class MyCircle extends StatelessWidget {
  final bool filled;
  final CircleConfig circleUIConfig;
  final double extraSize;

  MyCircle(
      {Key key,
      this.filled = false,
      @required this.circleUIConfig,
      this.extraSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: extraSize),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
          color: filled ? circleUIConfig.fillColor : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              color: circleUIConfig.borderColor,
              width: circleUIConfig.borderWidth)),
    );
  }
}