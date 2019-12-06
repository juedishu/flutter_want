import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/brand/brand_copy.dart';
import 'package:flutter_app/ui/child_fenlei/child_fenlei.dart';
import 'package:flutter_app/ui/goodsDetail/good_detail.dart';
import 'package:flutter_app/ui/no_found_page.dart';
import 'package:flutter_app/ui/setting/Setting.dart';
import 'package:flutter_app/ui/setting/about.dart';
import 'package:flutter_app/ui/setting/favorite.dart';
import 'package:flutter_app/ui/sort/search.dart';
import 'package:flutter_app/ui/topic/topic_detail.dart';
import 'package:flutter_app/utils/util_mine.dart';

class Router {
  static String plugin = Util.flutter2activity;
  static var demoPlugin = MethodChannel(plugin);

  static Map<String, Function> routes = {
    Util.goodDetailTag: (context, {arguments}) => GoodsDetail(arguments: arguments),//商品详情
    Util.brandTag: (context, {arguments}) => BrandCopy(arguments: arguments),
    Util.catalogTag: (context, {arguments}) => SortChild(arguments: arguments),//子分类
    Util.topicDetail: (context, {arguments}) => Topicdetail(arguments: arguments),//专题详情
    Util.search: (context, {arguments}) => SearchGoods(arguments: arguments),//专题详情
    Util.setting: (context, {arguments}) {
      var id = arguments['id'];
      switch (id) {
        case 0: //关于界面
          return AboutApp();
          break;
        case 1: //收藏界面
          return Favorite();
          break;
        case 2: //设置界面
          return Setting();
          break;
      }
      return NoFoundPage();
    },
  };

  ///组件跳转
  static link(Widget widget, String routeName, BuildContext context,
      [Map params, Function callBack]) {
    return GestureDetector(
      onTap: () {
        if (params != null) {
          Navigator.pushNamed(context, routeName, arguments: params)
              .then((onValue) {
            if (callBack != null) {
              callBack();
            }
          });
        } else {
          Navigator.pushNamed(context, routeName).then((onValue) {
            if (callBack != null) {
              callBack();
            }
          });
        }
      },
      child: widget,
    );
  }

  static run(RouteSettings routeSettings) {
    final Function pageContentBuilder = Router.routes[routeSettings.name];
    if (pageContentBuilder != null) {
      if (routeSettings.arguments != null) {
        return MaterialPageRoute(
            builder: (context) => pageContentBuilder(context,
                arguments: routeSettings.arguments));
      } else {
        // 无参数路由
        return MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
      }
    } else {
      return MaterialPageRoute(builder: (context) => NoFoundPage());
    }
  }

  static pop(context) {
    Navigator.pop(context);
  }
}