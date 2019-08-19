import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:flutter/material.dart';

TextEditingController _Name_Books_Controller;

class ButtonAddBooks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonAddBooks();
}

class _ButtonAddBooks extends State<ButtonAddBooks>{

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
          "My Books",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
        child:
        RaisedButton(
            onPressed:(){
              insert(context);
            },
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
      ],
    ),
    );
  }


}


void insert(BuildContext context){
MyBooks book = new MyBooks();
DataBaseHelperSQL _DBHelperSQL = new DataBaseHelperSQL();
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Insert new Book"),
        content: TextField(
          onChanged: (value){
            book.Name_Book = value;
          },
          decoration: InputDecoration(labelText: 'New Book'),),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Acept"),
            onPressed: (){
                _DBHelperSQL.newBook(book);
                Navigator.of(context).pop();
              },
          ),
        ],
      );
    }
  );

}


