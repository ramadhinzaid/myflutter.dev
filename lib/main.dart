import 'package:flutter/material.dart';
import 'package:zaid_study/AppRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyAppRoute _myAppRoute = MyAppRoute();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: _myAppRoute.onGenerateRoute,
      home: MyHomePage(title: 'Zaid Study'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/paralax'),
              leading: FlutterLogo(),
              title: Text("Parallax Scroll"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/camerafilter'),
              leading: FlutterLogo(),
              title: Text("Camera Filter"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/photofilter'),
              leading: FlutterLogo(),
              title: Text("Photo Filter"),
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed('/routemsg', arguments: "Route With Message"),
              leading: FlutterLogo(),
              title: Text("Route With Message"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/routeanimation'),
              leading: FlutterLogo(),
              title: Text("Route With Animation"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/routeanimations'),
              leading: FlutterLogo(),
              title: Text("Route 404"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/datamanajemen'),
              leading: FlutterLogo(),
              title: Text("Data Manajemen"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/login'),
              leading: FlutterLogo(),
              title: Text("Form Login"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed('/focusimage'),
              leading: FlutterLogo(),
              title: Text("Focus Image"),
            )
          ],
        ),
      ),
    );
  }
}
