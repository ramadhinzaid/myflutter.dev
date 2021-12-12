import 'package:flutter/material.dart';
import 'package:zaid_study/animation_route.dart';
import 'package:zaid_study/date-picker/date_picker_home.dart';
import 'package:zaid_study/drawer/mydrawers.dart';
import 'package:zaid_study/focus-image/focus_image.dart';
import 'package:zaid_study/forms/form_login.dart';
import 'package:zaid_study/main.dart';
import 'package:zaid_study/paralax/ParalaxHome.dart';
import 'package:zaid_study/photo-filter/home_photo_filter.dart';
import 'package:zaid_study/photo-filter/mycamera.dart';
import 'package:zaid_study/route/route_404.dart';
import 'package:zaid_study/route/route_animation.dart';
import 'package:zaid_study/route/route_msg.dart';
import 'package:zaid_study/work-with-data/Home.dart';
import 'package:zaid_study/work-with-data/fetch_data.dart';

class MyAppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MyHomePage(),
        );

      case '/paralax':
        return MaterialPageRoute(
          builder: (_) => ParalaxHome(),
        );

      case '/camerafilter':
        return MaterialPageRoute(
          builder: (_) => CameraScreen(),
        );

      case '/photofilter':
        return MaterialPageRoute(
          builder: (_) => HomePhotoFilter(),
        );

      case '/routemsg':
        return MaterialPageRoute(
          builder: (_) => RouteMessage(
            title: routeSettings.arguments,
          ),
        );

      case '/routeanimation':
        return rightleftRoute(
          RouteAnimation(),
        );

      case '/datamanajemen':
        return rightleftRoute(
          HomeData(),
        );

      case '/fetchdata':
        return rightleftRoute(
          FetchData(),
        );

      case '/login':
        return rightleftRoute(
          FormLogin(),
        );

      case '/focusimage':
        return rightleftRoute(
          BasePage(),
        );

      case '/date':
        return rightleftRoute(
          DateHome(),
        );
      case '/drawer':
        return rightleftRoute(
          MyDrawer(),
        );

      default:
        return scaleRoute(Route404());
    }
  }
}
