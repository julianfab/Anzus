import 'package:flutter/material.dart';
import 'package:anzus/routes.dart';
import 'package:anzus/theme.dart';
import 'package:anzus/HomeScreen//HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  Widget rootPage = new HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anzus',
      home: rootPage,
      routes: buildAppRoutes(),
      theme: buildAppTheme(),
    );
  }
}