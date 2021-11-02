import 'package:flutter/material.dart';

class Route404 extends StatelessWidget {
  const Route404({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 404"),
      ),
      body: Center(
        child: Text("No page found, check your route name"),
      ),
    );
  }
}
