import 'dart:math';
// Удален импорт 'dart:ui', так как он не используется
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppProvider());

class AppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider',
      home: MultiProvider(
        providers: [
          // Изменено имя класса с StateControll на StateController
          ChangeNotifierProvider<StateController>.value(
              value: StateController()),
        ],
        child: HomeProvider(),
      ),
    );
  }
}

// Изменено имя класса с StateControll на StateController
class StateController extends ChangeNotifier {
  // Изменено имя переменной _color на _isColorChanged
  bool _isColorChanged = false;

  // Изменено имя геттера с colorValue на isColorChanged
  bool get isColorChanged => _isColorChanged;

  // Изменено имя метода с changeColor на toggleColor
  void toggleColor() {
    _isColorChanged = !_isColorChanged;
    notifyListeners();
  }
}

class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Изменено имя класса с StateControll на StateController
    StateController _state = Provider.of<StateController>(context);
    final randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // Изменен цвет при условии, чтобы цвет изменялся в зависимости от состояния
        foregroundColor: _state.isColorChanged ? randomColor : Colors.white,
        title: Text('HomeWork Provider'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: 200.0,
              height: 200.0,
              // Изменен цвет при условии, чтобы цвет изменялся в зависимости от состояния
              color: _state.isColorChanged ? randomColor : Colors.grey,
            ),
            Switch(
              // Изменено имя переменной с colorValue на isColorChanged
              value: _state.isColorChanged,
              onChanged: (bool value) {
                // Изменено имя метода с changeColor на toggleColor
                _state.toggleColor();
              },
            ),
          ],
        ),
      ),
    );
  }
}
