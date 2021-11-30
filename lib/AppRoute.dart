import 'package:flutter/material.dart';
import 'package:route_animation/route_animation.dart';
import 'package:zaid_study/animation_route.dart';
import 'package:zaid_study/date-picker/date_picker_home.dart';
import 'package:zaid_study/drawer/index.dart';
import 'package:zaid_study/focus-image/focus_image.dart';
import 'package:zaid_study/forms/form_login.dart';
import 'package:zaid_study/getAPIbloc/views/getAlbumView.dart';
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
        break;
      case '/paralax':
        return MaterialPageRoute(
          builder: (_) => ParalaxHome(),
        );
        break;
      case '/camerafilter':
        return MaterialPageRoute(
          builder: (_) => CameraScreen(),
        );
        break;
      case '/photofilter':
        return MaterialPageRoute(
          builder: (_) => HomePhotoFilter(),
        );
        break;
      case '/routemsg':
        return MaterialPageRoute(
          builder: (_) => RouteMessage(
            title: routeSettings.arguments,
          ),
        );
        break;
      case '/routeanimation':
        return AnimateRoute.scaleRoute(
          RouteAnimation(),
        );
        break;
      case '/datamanajemen':
        return rightleftRoute(
          HomeData(),
        );
        break;
      case '/fetchdata':
        return rightleftRoute(
          FetchData(),
        );
        break;
      case '/fetchdatabloc':
        return rightleftRoute(
          AlbumView(),
        );
        break;
      case '/login':
        return rightleftRoute(
          FormLogin(),
        );
        break;
      case '/focusimage':
        return rightleftRoute(
          BasePage(),
        );
        break;
      case '/date':
        return rightleftRoute(
          DateHome(),
        );
        break;
      case '/drawer':
        return rightleftRoute(
          DrawerHome(),
        );
        break;
      default:
        return scaleRoute(Route404());
    }
  }
}
