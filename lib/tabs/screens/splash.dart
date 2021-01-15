
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'tab.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new TabBarDemo(),
      title: new Text('Без еды ни куда',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent,
        fontSize: 30.0,
      ),),
      image: new Image.network('https://i.imgur.com/MOW19Ip.jpg'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      loaderColor: Colors.deepPurpleAccent,
    );
  }
}