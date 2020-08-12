# Лучшие практики написания кода на Dart / Flutter

##
```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
```

<details><summary>CLICK ME</summary>
<p>  

#### yes, even hidden code blocks!

```dart
if(optionalThing?.isEnabled ?? false) { ... } // Good
if(optionalThing?.isEnabled == true) { ... } // Bad
```

</p>
</details>
