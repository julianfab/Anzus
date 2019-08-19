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
    return _getBody();
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

}