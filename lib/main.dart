import 'dart:math';
// Удален импорт 'dart:ui', так как он не используется
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(SwitchColorApp());

class SwitchColorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Work',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<StateController>(
              create: (_) => StateController())
        ],
        child: HomeScreen(),
      ),
    );
  }
}

class StateController extends ChangeNotifier {
  bool _ifColorChanged = false;

  bool get ifColorChanger => _ifColorChanged;

  void toggleColor() {
    _ifColorChanged = !_ifColorChanged;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateController _state = Provider.of<StateController>(context);
    final randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: _state.ifColorChanger ? randomColor : Colors.white,
        title: Text(
          'HomeWork Provider',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: 200,
              height: 200,
              color: _state.ifColorChanger ? randomColor : Colors.grey,
            ),
            Switch(
                value: _state.ifColorChanger,
                onChanged: (bool value) {
                  _state.toggleColor();
                })
          ],
        ),
      ),
    );
  }
}
