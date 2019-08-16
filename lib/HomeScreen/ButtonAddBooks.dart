import 'package:flutter/material.dart';
import 'package:anzus/routes.dart';

class ButtonAddBooks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonAddBooks();
}

class _ButtonAddBooks extends State<ButtonAddBooks>{


  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 1.0),
           child: Row (
             crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("My Books"),
                    )
                  ],
               ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                     Container(
                         margin: const EdgeInsets.only(left: 140),
                         child:  RaisedButton(
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
                      )
                    ]
                )
              ],
            )
          )
        ],
      ),
    );
  }
}