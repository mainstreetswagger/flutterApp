import 'package:flutter/material.dart';
import 'screens/data.dart';

class App extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: 'Введите ваши персональные данные',
      home: Scaffold(
        body: DataScreen(),
      ),
    );
  }
}