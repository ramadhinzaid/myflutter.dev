import 'package:flutter/material.dart';

class ZaidAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZaidAppBar({Key key, this.title = "AppBar"}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
