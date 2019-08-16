import 'package:flutter/material.dart';

class ListMyBooks extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _ListMyBooks();
}

class _ListMyBooks extends State<ListMyBooks>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                color: Colors.amber,
                width: 126.0,
                child: Text(
                  "vacio",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                color: Colors.blue,
                width: 126.0,
                child: Text(
                  "vacio",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                color: Colors.deepOrange,
                width: 126.0,
                child: Text(
                  "vacio",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}