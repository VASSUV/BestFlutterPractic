
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameItem {
  final ValueNotifier<int> notifier;
  GameItem(int position): notifier = ValueNotifier<int>(position);

  int get position => notifier.value;
  set position(int value) => notifier.value = value;

  double get topPercent => ((position - position % 4) / 4) / 4;
  double get leftPercent => (position % 4) / 4;
}

class GameCellWidget extends StatelessWidget {
  final double size;
  final void Function() onTap;

  const GameCellWidget({Key key, this.size, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = (key as ValueKey).value + 1;
    return InkWell(
      onTap: onTap,
      child: Container(height: size, width: size, child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
              value.toString(),
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              )
          ),
        ),
      )),
    );
  }
}