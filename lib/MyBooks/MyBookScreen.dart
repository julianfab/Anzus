import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:anzus/Model/ModelTopics.dart';
import 'package:anzus/view/list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBookScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyBookScreen();
}




class _MyBookScreen extends State<MyBookScreen> {


  List<MyBooks> list;
  DataBaseHelperSQL _DBHelperSQL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        label: Text("Add"),
        icon: Icon(
          Icons.library_add,
          color: Colors.white,
        ),
        onPressed: () {
          insert(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _getBody(),
    );
  }
  /*
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => Home()),
  ),*/
  void insert(BuildContext context) {
    MyBooks book = new MyBooks();
    DataBaseHelperSQL _DBHelperSQL = new DataBaseHelperSQL();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Insert new Book"),
            content: TextField(
              onChanged: (value) {
                book.Name_Book = value;
              },
              decoration: InputDecoration(labelText: 'New Book'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Acept"),
                onPressed: () {
                  _DBHelperSQL.newBook(book);
                  updateList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }




  void onDeletedRequest(int index){
    MyBooks book = list[index];
    _DBHelperSQL.deleteBook(book).then((value){
      setState(() {
        list.removeAt(index);
        _DBHelperSQL.deleteTopic(book.id);
      });
    });


  }

  void Updatebook(int index){
    MyBooks book = list[index];
    final textfieldcontrol = TextEditingController(text: book.Name_Book);

    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit Book"),
            content: TextField(
              controller: textfieldcontrol,
              onChanged: (value) {
                book.Name_Book = value;
              },
              decoration: InputDecoration(labelText: 'New name the book'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Update"),
                onPressed: () {
                  _DBHelperSQL.updateBook(book);
                  updateList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



  Widget _getBody() {
    if (list == null) {
      return CircularProgressIndicator();
    } else if (list.length == 0) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Text( "My Books",
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
              Text("Empty List",
                style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                ),
              )
            ]
          )
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
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
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, position) {
                      MyBooks book = list[position];
                      return BookWidget(book,onDeletedRequest,position,Updatebook);
                    }),
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

  void updateList() {
    _DBHelperSQL.getAllMyBooks().then((res) {
      setState(() {
        list = res;
      });
    });
  }

}

typedef OnDeleted = void Function(int position);
typedef OnUpdate = void Function(int position);

class BookWidget extends StatelessWidget {
  final MyBooks book;
  final OnDeleted onDeleted;
  final int position;
  final OnUpdate onUpdate;
  DataBaseHelperSQL _DBHelperSQL = new DataBaseHelperSQL();
  BookWidget(this.book, this.onDeleted,this.position,this.onUpdate);
  var _option = [
    'Edit',
    'Delete',
  ];

  @override
  Widget build(BuildContext context) {
    Topics topic = new Topics();
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key("${book.id}"),
        child: new GestureDetector(
          onTap: (){
            _DBHelperSQL.getTopics(book.id).then((res){
              if(res == null){
                topic.id = book.id;
                topic.Name_Topic = "Topic"+book.Name_Book;
                _DBHelperSQL.newTopics(topic);
                Navigator.of(context).push(MaterialPageRoute(builder: (c){
                  return NotesListPage(this.book);
                }));
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (c){
                  return NotesListPage(this.book);
                }));
              }
            });
          },
          child: new Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        book.Name_Book,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.mode_edit,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      onPressed: (){
                        this.onUpdate(this.position);
                      },
                    )
                  ],
                ),
              )
          ),
        ),
        onDismissed: (direction){
        onDeleted(this.position);
        },
        confirmDismiss: (DismissDirection dismissDirection) async {
        if(dismissDirection == DismissDirection.endToStart){
          return await _showConfirmationDialog(context, 'Delete') == true;
        }
        return false;
    },
      background: Container(
        color: Colors.deepOrange,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.trash,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
            ),
            Text("Delete", style: TextStyle(color: Colors.white),)
          ],
        ),
      )
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, String action) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you wish to $action this item?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
}

