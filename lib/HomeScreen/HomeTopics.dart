import 'package:flutter/material.dart';

class HomeTopics extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeTopics();
}

class _HomeTopics extends State<HomeTopics>{

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              "Topics",
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
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Topic 1"),
                      Text("from book1"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Topic 2"),
                      Text("from book2"),
                    ],
                  ),
                ),Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Topic 3"),
                      Text("from book3"),
                    ],
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}