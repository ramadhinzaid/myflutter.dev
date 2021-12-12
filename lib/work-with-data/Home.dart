import 'package:flutter/material.dart';
import 'package:zaid_study/appbar.dart';

class HomeData extends StatelessWidget {
  const HomeData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZaidAppBar(title: "Home Data"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/fetchdata'),
              leading: FlutterLogo(),
              title: Text("Fetch Data From Internet"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/fetchdatabloc'),
              leading: FlutterLogo(),
              title: Text("Fetch Data From Internet Using Bloc"),
            ),
          ],
        ),
      ),
    );
  }
}
