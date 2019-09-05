import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:anzus/Model/ModelTopics.dart';
import 'package:anzus/Model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class HomeTopics extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeTopics();
}

class _HomeTopics extends State<HomeTopics>{
  List<MyBooks> list;
  Topics topic;
  Directory dir;
  DataBaseHelperSQL _DBHelperSQL;
  var nom;
  final formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  List<Note> _notes;

  Future<void> _loadNotes() async {
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir =  directory;
      File jsonFile = new File(dir.path+'/${topic.Name_Topic}'+'.json');
      bool fileExists = jsonFile.existsSync();
      if (fileExists) {
        print('ko');
        print(jsonFile.readAsStringSync());
        this.setState(() => _notes = Note.allFromResponse(jsonFile.readAsStringSync()));
      }else{
        print('ki');
        jsonFile.create();
        Map<String, dynamic> pe = {
          "results":[
          ]
        };
        jsonFile.writeAsString(json.encode(pe));
        _loadNotes();
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    if(list==null){
      return CircularProgressIndicator();
    }else if(list.length==0){
      return Text("Esta vacio");
    }
    else{
      return  Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${nom}",
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
              _getBody(),
            ],
          )
      );
    }
  }


  Widget _getBody() {
    Widget _buildNoteListTile(BuildContext context, int index) {
      var note = _notes[index];
      return new Card(
          child: ListTile(
            title: Text(note.title,
              style: TextStyle(
              fontSize: 22.0,
              color: Colors.deepOrangeAccent,
            ),),
            subtitle: Text(formatter.format(note.date),
              style: TextStyle(
              fontSize: 22.0,
              color: Colors.deepOrangeAccent,
            ),),
          )
      );
    }

    if (_notes == null) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
          child: Column(
              children: <Widget>[
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
    } else if (_notes.length == 0) {
      return Text("Esta vacio");
    } else {
      return Container(
        margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 100.0,
                  child:  ListView.builder(
                    itemExtent: 100.0,
                    itemCount: _notes.length,
                    itemBuilder: _buildNoteListTile,
                  ),
                )
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
        print(list.length);
        updateListTopic(list.length);
      });
    });
  }

  void updateListTopic(int id){
    var rng = new Random();
    var numb = rng.nextInt(id);
    if(id!=0){
      _DBHelperSQL.getTopics(list[numb].id).then((res){
        setState(() {
          topic = res;
          nom=topic.Name_Topic;
          _loadNotes();
        });
      });
    }
  }
}