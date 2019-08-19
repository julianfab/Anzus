import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:flutter/material.dart';

class MyBookScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyBookScreen();
}

class _MyBookScreen extends State<MyBookScreen>{
  List<MyBooks> list;
  DataBaseHelperSQL _DBHelperSQL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.library_add,
          color: Colors.white,
        ),
        onPressed: () {
          insert(context);
        },
      ),
      body: _getBody(),
    );
  }


  Widget _getBody() {
    if (list == null) {
      return CircularProgressIndicator();
    } else if (list.length == 0) {
      return Text("Esta vacio");
    } else {
      return Container(
          margin: EdgeInsets.only(top:25.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Text(
                  "My Books",
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
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child:  ListView.builder(
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
            ),
        ],
      ),
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