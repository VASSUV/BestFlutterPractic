import 'dart:math';

import 'GameCellWidget.dart';

class GameBloc {
  final double size;
  final items = List<GameItem>.generate(15, (i) => GameItem(i));
  var spacePosition = 15;

  GameBloc(this.size);

  void reset() {
    final set = List<int>.generate(15, (i) => i)
      ..shuffle();
    for (int i = 0; i < 15; i++)
      items[i].position = set[i];
    spacePosition = 15;
  }

  bool checkWin() {
    for (int i = 0; i < items.length; i++) {
      if (items[i].position != i) return false;
    }
    return true;
  }

  int row(int position) => (position - position % 4) ~/ 4;

  int column(int position) => position % 4;

  bool isInRow(int position) => row(spacePosition) == row(position);

  bool isInColumn(int position) => column(spacePosition) == column(position);

  void onTap(int cellIndex) {
    final isRow = isInRow(cellIndex);
    final isColumn = isInColumn(cellIndex);
    final item = items.firstWhere((element) => element.position == cellIndex);
    final tapPosition = item.position;
    final delta = (item.position < spacePosition ? 1 : -1) * (isRow ? 1 : 4);
    if (isRow != isColumn) {
      final start = min(item.position, spacePosition);
      final end = max(item.position, spacePosition);
      items.forEach((element) {
        if (start <= element.position && element.position <= end &&
            (end - element.position) % delta == 0) {
          element.position += delta;
        }
      });
      spacePosition = tapPosition;
    }
  }
}