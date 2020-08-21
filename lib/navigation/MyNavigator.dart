import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RouteType { cupertino, material }

class GlobalNavigator extends MyNavigator {
  static final global = GlobalNavigator();

  static final globalKey = GlobalKey<NavigatorState>();
  NavigatorState get _state => globalKey.currentState;
}

class LocalNavigator extends MyNavigator {
  final NavigatorState _state;
  LocalNavigator(BuildContext context) : this._state = Navigator.of(context);
}

abstract class MyNavigator {
  NavigatorState get _state;

  Route<T> _route<T extends Object>(Widget widget, {
    RouteType routeType
  }) {
    if(routeType == RouteType.material) {
      return MaterialPageRoute(builder: (context) => widget);
    } else {
      return CupertinoPageRoute(builder: (context) => widget);
    }
  }

  Future<T> goTo<T extends Object>(Widget page) {
    return _state.push(_route(page));
  }

  Future<T> changePage<T extends Object, TO extends Object>(
      StatefulWidget page, { TO result }) {
    return _state.pushReplacement(_route(page), result: result);
  }

  Future<T> exampleGoToMaterial<T extends Object>(StatefulWidget page) {
    return _state.push(_route(page, routeType: RouteType.material));
  }

  void back<T extends Object>([T result]) {
    _state.pop(result);
  }
}
