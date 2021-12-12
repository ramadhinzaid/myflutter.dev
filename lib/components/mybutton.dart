import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
TextButton MyButton({
  Function onPressed,
  Widget child,
}) =>
    TextButton(onPressed: onPressed, child: child);

TextStyle primaryTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

// ignore: non_constant_identifier_names
Text MyText({String value, TextStyle btntxtStyle}) => Text(
      value,
      style: btntxtStyle,
    );
