# Лучшие практики написания кода на Dart / Flutter

## Рекомендации
* Не используй `this`, кроме перенаправления на именованный конструктор или для избегания затенения.

## 
```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
```

## Константы и постоянные

Почитайте разницу между ними - https://habr.com/ru/post/501804/

```dart 
const myList = [1, 2, 3];
const myMap = {'one': 1};
const mySet = {1, 2, 3};
const myConstNumber = 5;

final myList = [1, 2, 3];
final myMap = {'one': 1};
final mySet = {1, 2, 3};
final myConstNumber = 5; 

```

## Инициализация объектов
```dart
// Good
Task.oneShot();
Task.repeating();
ListBox(scroll: true, showScrollbars: true);
Button(ButtonState.enabled);

// Bad
Task(true);
Task(false);
ListBox(false, true, true);
Button(false);
```

### Инициализация коллекций
```dart 
// Good
var points = <Point>[];
var addresses = <String, Address>{};
var counts = <int>{};
var ints = <num>[1, 2];
List<num> ints = [1, 2];
Set<String> things = Set();
var things = Set<String>();

// Bad
var points = List<Point>();
var addresses = Map<String, Address>();
var counts = Set<int>();
List<num> ints = <num>[1, 2];
```

### Наполнение коллекций
```dart  
Widget build(BuildContext context) {
  return Column(children: [
    Header(),
    ...buildMainElements(),
    Footer(),
  ]);
} 

Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    if (page != pages.last)
      FlatButton(child: Text('Next')),
  ]);
} 

Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    for (var section in sections)
      HeadingAction(section.heading),
  ]);
}
```

## Использование циклов
```dart  
for (var person in people) { ... } // Good
people.forEach(print); // Good
people.forEach((person) => ...); // Bad
for (Person person in people) { ... } // Bad
people.forEach((Person person) => ...) // Bad
```

## Локальные функции
```dart 
// Good
void main() {
  void localFunction() {
    ...
  }
}

// Bad
void main() {
  var localFunction = () {
    ...
  };
}
```

## Сокращенный вариант функций
```dart
double get area => (right - left) * (bottom - top);

bool isReady(double time) =>
    minTime == null || minTime <= time;

String capitalize(String name) =>
    '${name[0].toUpperCase()}${name.substring(1)}';
``` 

## Объявление функций
```dart
Future<bool> install(PackageId id, String destination) => ... // Good
dynamic mergeJson(dynamic original, dynamic changes) => ... // Good
install(id, destination) => ... // Bad, Very Bad!!! (Все типы по умолчанию dynamic)
mergeJson(original, changes) => ... // Bad
```

### Передача функций через параметры
```dart
bool isValid(String value, bool Function(String) test) => ... // Good
bool isValid(String value, Function test) => ... // Bad
```

## Сеттеры и геттеры
```dart
// Good
num get x => center.x;
set x(num value) => center = Point(value, center.y);
set foo(Foo value) { ... }

// Bad
void set foo(Foo value) { ... }
```

## Используйте await в асинхронных функциях
```dart
// Good
Future<int> countActivePlayers(String teamName) async {
  try {
    var team = await downloadTeam(teamName); 
    var players = await team.roster;
    return players.where((player) => player.isActive).length;
  } catch (e) {
    log.error(e);
    return 0;
  }
}

//Bad
Future<int> countActivePlayers(String teamName) {
  return downloadTeam(teamName).then((team) { 
    return team.roster.then((players) {
      return players.where((player) => player.isActive).length;
    });
  }).catchError((e) {
    log.error(e);
    return 0;
  });
}
```

## Не используйте `async` если в этом нет необходимости(когда не используется `await`)

```dart
// Good
Future<void> afterTwoThings(
    Future<void> first, Future<void> second) {
  return Future.wait([first, second]);
}

//Bad
Future<void> afterTwoThings(Future<void> first, Future<void> second) async {
  return Future.wait([first, second]);
}
```

## Использование каскадных вызовов

```dart
// Good
var buffer = StringBuffer()
  ..write('one')
  ..write('two')
  ..write('three');

//Bad
var buffer = StringBuffer()
    .write('one')
    .write('two')
    .write('three');
```

## Расширения для классов
```dart
void main() {
  final cube = Cube(width: 2.0);
  print('Cube area: ${cube.square}'); // Cube area: 4
  print('Scaled cube area: ${cube.scale(1.5).square}'); // Scaled cube area: 9
  print('Scaled cube area: ${(cube ^ 2.5).square}'); // Scaled cube are: 25
}

class Cube {
  final double width;
  Cube({@required this.width});
}

extension CubeExtensions on Cube {
  double get square => width * width;
  Cube operator ^(double factor) => Cube(width: width * factor);
  Cube scale(double factor) => this ^ factor;
}
```

<details><summary>CLICK ME</summary>
<p>  

## Игра Пятнашки

Можно позапускать и поиграться в DartPad 

https://dartpad.dev/6f17ca1a1f9e135b296c84880de15132 

## Навигация

Локальный и Глобальный навигаторы

https://dartpad.dev/c0129fb43213c46467a4084e61eefdda

#### Скрытый блок кода!

```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
```

</p>
</details>
