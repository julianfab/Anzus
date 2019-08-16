import 'package:flutter/material.dart';

class Reminders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Reminders();
}

class _Reminders extends State<Reminders> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Text(
            "Reminders ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          new Divider(
            endIndent: 20.0,
            indent: 20.0,
            color: Colors.black,
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Reminders 1"),
                  Text("Fecha"),
                  Text("Hora"),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Reminders 2"),
                  Text("Fecha"),
                  Text("Hora"),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}