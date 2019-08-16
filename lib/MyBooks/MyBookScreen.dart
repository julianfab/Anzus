import 'package:flutter/material.dart';

class MyBookScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyBookScreen();
}

class _MyBookScreen extends State<MyBookScreen>{
  Widget build(BuildContext context) {
    return Center(
      child: Text("MyBooks"),
    );
  }
}