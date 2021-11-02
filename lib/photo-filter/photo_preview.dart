import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  final XFile imgFile;
  const Preview({Key key, @required this.imgFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.file(
          File(imgFile.path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
