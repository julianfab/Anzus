import 'package:flutter/material.dart';
import 'package:anzus/HomeScreen/ListMyBooks.dart';
import 'package:anzus/HomeScreen/ButtonAddBooks.dart';
import 'package:anzus/HomeScreen/Reminders.dart';
import 'package:anzus/HomeScreen/HomeTopics.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home>{

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ButtonAddBooks(),
              new Divider(
                endIndent: 20.0,
                indent: 20.0,
                color: Colors.black,
              ),
              ListMyBooks(),
              Reminders(),
              HomeTopics(),
            ]
        ),
    );
  }
}