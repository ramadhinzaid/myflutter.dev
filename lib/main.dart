import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zaid_study/AppRoute.dart';
import 'package:zaid_study/getAPIbloc/blocs/getAlbumbloc/getalbum_bloc.dart';
import 'package:zaid_study/getAPIbloc/repository/getAlbumrepo/getAlbumrepo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyAppRoute _myAppRoute = MyAppRoute();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetalbumBloc>(
            create: (context) => GetalbumBloc(GetAlbumRepository()))
      ],
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('id')],
        locale: const Locale('id'),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _myAppRoute.onGenerateRoute,
        home: MyHomePage(title: 'Zaid Study'),
      ),
    );
    // return MaterialApp(
    //   localizationsDelegates: [GlobalMaterialLocalizations.delegate],
    //   supportedLocales: [const Locale('id')],
    //   locale: const Locale('id'),
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   onGenerateRoute: _myAppRoute.onGenerateRoute,
    //   home: MyHomePage(title: 'Zaid Study'),
    // );
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
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
                onTap: () =>
                    Navigator.of(context).pushNamed('/routeanimations'),
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
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed('/date'),
                leading: FlutterLogo(),
                title: Text("Date Picker"),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed('/drawer'),
                leading: FlutterLogo(),
                title: Text("Drawer"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
