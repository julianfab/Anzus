import 'package:flutter/material.dart';
import 'package:anzus/HomeScreen/ListMyBooks.dart';
import 'package:anzus/HomeScreen/ButtonAddBooks.dart';

class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home>{

  @override

  Widget build(BuildContext context) {

    return Container(
        child: ListView(
            children: <Widget>[
              ButtonAddBooks(),
              ListMyBooks(),
            ]
        ),
    );
  }
}