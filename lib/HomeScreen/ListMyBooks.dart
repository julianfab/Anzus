import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:flutter/material.dart';

class ListMyBooks extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _ListMyBooks();
}

class _ListMyBooks extends State<ListMyBooks>{
  List<MyBooks> list;
  DataBaseHelperSQL _DBHelperSQL;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          Row(
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
          new Divider(
            endIndent: 20.0,
            indent: 20.0,
            color: Colors.black,
          ),
          _getBody()
        ],
      ),
    );








  }


  Widget _getBody() {
    if (list == null) {
      return CircularProgressIndicator();
    } else if (list.length == 0) {
      return Text("Esta vacio");
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                height: 100.0,
                child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 100.0,
                    itemCount: list.length,
                    itemBuilder: (context, position) {
                      return Card(
                         child: ListTile(
                            title: Text('${list[position].Name_Book}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          )
                      );
                    }
                ),
            ),
          )
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _DBHelperSQL = new DataBaseHelperSQL();
      updateList();
    });
  }

  void  updateList(){
    _DBHelperSQL.getAllMyBooks().then((res){
      setState(() {
        list = res;
      });
    });
  }

  void insert(BuildContext context){
    MyBooks book = new MyBooks();
    DataBaseHelperSQL _DBHelperSQL = new DataBaseHelperSQL();
    showDialog(
      barrierDismissible: false,
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
                  updateList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );

  }

}

