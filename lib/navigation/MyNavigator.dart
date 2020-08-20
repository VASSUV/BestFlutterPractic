import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RouteType { cupertino, material }

class MyNavigator {
  static final global = MyNavigator._global(GlobalKey<NavigatorState>());
  static MyNavigator get local => MyNavigator._local();

  GlobalKey<NavigatorState> navigatorKey;

  MyNavigator._global(this.navigatorKey);

  factory MyNavigator._local() {
    final context = global.navigatorKey.currentContext;

    final key = MyNavigatorLocalProvider.of(context)?.getCurrentKey();

    if(key != null) return MyNavigator._global(key);
    return global;
  }

  Future<T> goTo<T extends Object>(StatefulWidget page) {
    return navigatorKey.currentState.push(_route(page));
  }

  Future<T> changePage<T extends Object, TO extends Object>(StatefulWidget page, { TO result }) {
    return navigatorKey.currentState.pushReplacement(_route(page), result: result);
  }

  Future<T> exampleOpenMaterial<T extends Object>(StatefulWidget page) {
    return navigatorKey.currentState.push(_route(page, routeType: RouteType.material));
  }

  void back<T extends Object>([T result]) {
    navigatorKey.currentState.pop(result);
  }
}


Route<T> _route<T extends Object>(StatefulWidget widget, {
  RouteType routeType
}) {
  switch(routeType) {
    case RouteType.cupertino:
      return CupertinoPageRoute(builder: (context) => widget);
    case RouteType.material:
      return MaterialPageRoute(builder: (context) => widget);
  }
  return CupertinoPageRoute(builder: (context) => widget);
}

class MyNavigatorLocalProvider extends InheritedWidget {
  final Widget child;
  final GlobalKey<NavigatorState> Function() getCurrentKey;

  const MyNavigatorLocalProvider({@required this.child, @required this.getCurrentKey});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static MyNavigatorLocalProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyNavigatorLocalProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}