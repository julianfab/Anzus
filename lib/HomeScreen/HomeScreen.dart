import 'package:flutter/material.dart';
import 'package:anzus/HomeScreen/ListMyBooks.dart';
import 'package:anzus/HomeScreen/Home.dart';
import 'package:anzus/MyBooks/MyBookScreen.dart';

//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectDrawerItem =0;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return Home();
      case 1: return MyBookScreen();
    }
  }

  _onSelectItem(int pos){
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
          child: Text('ANZUS'),
        ),
        actions: <Widget>[
          Icon(Icons.ac_unit),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.notifications)
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text('HEADER')),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              selected: true,
              onTap: (){
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('My Books'),
              leading: Icon(Icons.library_books),
              selected: true,
              onTap: (){
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('Archived'),
              leading: Icon(Icons.archive),
              onTap: (){},
            ),
            ListTile(
              title: Text('Store'),
              leading: Icon(Icons.store),
              onTap: (){},
            ),
            ListTile(
              title: Text('Medals'),
              leading: Icon(Icons.beenhere),
              onTap: (){},
            ),
            ListTile(
              title: Text('Collection'),
              leading: Icon(Icons.collections_bookmark),
              onTap: (){},
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: (){},
            ),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectDrawerItem),
    );
  }


}