# Лучшие практики написания кода на Dart / Flutter

## Рекомендации
* Не используй `this, кроме перенаправления на именованный конструктор или для избегания затенения.

## 
```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
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

<details><summary>CLICK ME</summary>
<p>  


#### Скрытый блок кода!

```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
```

</p>
</details>
