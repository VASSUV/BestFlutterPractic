import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'GameWidget.dart';

//void main() {
//  runApp(GameApp());
//}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game Demo',
      home: Scaffold(
        body: GamePage()
      ),
    );
  }
}

class GamePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Game 15')),
        body: Builder(builder: (context) {
          final size = min(
              MediaQuery.of(context).size.height - 150,
              MediaQuery.of(context).size.width
          );
          final controller = GameController(size: size);
          return Container(width: double.maxFinite,
            child: Column(mainAxisSize: MainAxisSize.max,
              children: [
                GameWidget(controller: controller),
                RaisedButton(child: Text("Перемешать"), onPressed: controller.shuffle)
              ],
            ),
          );
        })
    );
  }
}
