
import 'package:bestpracticflutter/game/GameCellWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'GameBloc.dart';

class GameController {
  final GameBloc bloc;

  GameController({@required double size}): bloc = GameBloc(size);

  void shuffle() {
    bloc.reset();
  }
}

class GameWidget extends StatelessWidget {
  final GameController controller;

  GameWidget({@required this.controller});

  @override
  Widget build(BuildContext context) {
    final bloc = controller.bloc;
    return Container(color: Colors.amberAccent, width: bloc.size, height: bloc.size, child: Stack(
      children: [
        for(int i = 0; i < bloc.items.length; i++)
          ValueListenableBuilder(
            valueListenable: bloc.items[i].notifier,
            builder: (context, value, child) =>
                AnimatedPositioned(
                  child: child ?? GameCellWidget(
                      key: ValueKey(i),
                      size: bloc.size / 4,
                      onTap: () => bloc.onTap(value)
                  ),
                  duration: const Duration(milliseconds: 500),
                  left: bloc.items[i].leftPercent * bloc.size,
                  top: bloc.items[i].topPercent * bloc.size,
                ),
          )
      ],
    ));
  }
}