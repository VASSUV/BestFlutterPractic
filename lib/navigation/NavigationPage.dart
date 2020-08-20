import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyNavigator.dart';

//void main() {
//  runApp(NavigationApp());
//}

class NavigationApp extends StatelessWidget {
  final _selectedPage = ValueNotifier(0);

  final _keys = List.generate(3, (index) => GlobalKey<NavigatorState>());

  @override
  Widget build(BuildContext context) {
    return MyNavigatorLocalProvider(
      getCurrentKey: () => _keys[_selectedPage.value],
      child: MaterialApp(
        navigatorKey: MyNavigator.global.navigatorKey,
        title: 'Flutter Navigation Demo',
        home: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: _selectedPage,
            builder: (context, value, child) {
              return IndexedStack(
                index: value,
                children: [
                  for(int i = 0; i < _keys.length; i++)
                    Navigator(
                        key: _keys[i],
                        onGenerateRoute: (settings) => CupertinoPageRoute(
                            builder: (context) => NavigationPage(pageValue: i, stackValue: 0)
                        )
                    )
                ],
              );
            }
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: _selectedPage,
            builder: (context, value, child) {
              return BottomNavigationBar (
                onTap: (page) => _selectedPage.value = page,
                currentIndex: value,
                items: const [
                  BottomNavigationBarItem(title: Text("Call"), icon: Icon(Icons.call)),
                  BottomNavigationBarItem(title: Text("Message"), icon: Icon(Icons.message)),
                  BottomNavigationBarItem(title: Text("More"), icon: Icon(Icons.more_horiz))
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  int stackValue;
  int pageValue;

  NavigationPage({this.pageValue, this.stackValue, Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageValue == 0 ? "Call" : (widget.pageValue == 1 ? "Message" : "More")),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Страница: ${widget.stackValue}"),
            MaterialButton(child: Text("Дальше c Bottom Bar"), onPressed: () {
              MyNavigator.local.goTo(NavigationPage(pageValue: widget.pageValue, stackValue: widget.stackValue + 1));
            }),
            MaterialButton(child: Text("Дальше без Bottom Bar"), onPressed: () {
              MyNavigator.global.goTo(NavigationPage(pageValue: widget.pageValue, stackValue: widget.stackValue + 1));
            })
          ],
        ),
      ),
    );
  }
}