import 'package:flutter/material.dart';
import 'package:anzus/routes.dart';

class ButtonAddBooks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonAddBooks();
}

class _ButtonAddBooks extends State<ButtonAddBooks>{


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
       Text(
      "My Books",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
        RaisedButton(
            onPressed:(){},
            color: Colors.green,
            child: Text(
              "Add Books",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            )
        )
      ],
    ),
    );
  }
}