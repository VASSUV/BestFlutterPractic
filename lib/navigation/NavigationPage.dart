import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyNavigator.dart';

//void main() {
//  runApp(NavigationApp());
//}

class NavigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalNavigator.globalKey,
      title: 'Flutter Navigation Demo',
      home: BottomNavigationPage(),
    );
  }
}

const tabs = {
  "Call" : Icons.call,
  "Message" : Icons.message,
  "More" : Icons.more_horiz
};

class BottomNavigationPage extends StatelessWidget { 
  final _selectedPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _selectedPage,
          builder: (context, value, child) {
            return IndexedStack(
              index: value,
              children: buildTabNavigators(),
            );
          }
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  List<Widget> buildTabNavigators() => [ 
    for(int i = 0; i < tabs.length; i++)
      Navigator(onGenerateRoute: (settings) =>
          CupertinoPageRoute(builder: (context) =>
              MyPage(pageValue: i, stackValue: 0)
          )
      )
  ]; 

  ValueListenableBuilder<int> buildBottomBar() {
    return ValueListenableBuilder(
        valueListenable: _selectedPage,
        builder: (context, value, child) {
          return BottomNavigationBar(
            onTap: (page) => _selectedPage.value = page,
            currentIndex: value,
            items: [
              for(int i = 0; i < tabs.length; i++)
                BottomNavigationBarItem(
                    title: Text(tabs.keys.elementAt(i)),
                    icon: Icon(tabs[tabs.keys.elementAt(i)])
                )
            ],
          );
        }
    );
  }
}

class MyPage extends StatelessWidget {
  int stackValue;
  int pageValue;

  MyPage({this.pageValue, this.stackValue, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tabs.keys.elementAt(pageValue))),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Страница: $stackValue"),
            SizedBox(height: 32),
            MaterialButton(
                child: Text("Дальше c Bottom Bar"),
                onPressed: () => nextWith(LocalNavigator(context))
            ),
            MaterialButton(
                child: Text("Дальше без Bottom Bar"),
                onPressed: () => nextWith(GlobalNavigator.global)
            )
          ],
        ),
      ),
    );
  }

  void nextWith(MyNavigator navigator) {
    navigator.goTo(MyPage(
        pageValue: pageValue,
        stackValue: stackValue + 1
    ));
  }
}