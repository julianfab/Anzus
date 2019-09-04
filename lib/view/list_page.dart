import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:anzus/Model/ModelTopics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';//date formatter
import 'package:path_provider/path_provider.dart';
import 'full_page.dart';//detail page
import '../Model/note.dart';//note model
import 'package:path/path.dart' as p;

class NotesListPage extends StatefulWidget {
  final MyBooks book;

  NotesListPage(this.book);

  @override
  _NotesListPageState createState() => _NotesListPageState(book);
}

class _NotesListPageState extends State<NotesListPage> {
  final MyBooks books;
  Directory dir;
  DataBaseHelperSQL _DBHelperSQL = new DataBaseHelperSQL();
  Topics topic;
  Note note;
  _NotesListPageState(this.books);
  Map<String, dynamic> _notess;
  List<Note> _notes;
  final formatter = DateFormat('yyyy-MM-dd hh:mm:ss');

  void _addNote() {
    final note = Note(title: "", text: Note.emptyText, date: DateTime.now().toLocal());
    _navigateToNoteDetails(note, null, startEditing: true);
  }

  Future<File> get _localPath async {
    dir = await getApplicationDocumentsDirectory();
    Directory(dir.path+'/'+'Topic${books.Name_Book}.json')
        .createSync(recursive: true);
    return File(dir.path+'/'+'Topic${books.Name_Book}.json'); //path takes strings and not Path objects
  }

  Future<void> _loadNotes() async {
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir =  directory;
      File jsonFile = new File(dir.path+'/'+'Topic${books.Name_Book}.json');
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


  void _navigateToNoteDetails(Note note, int index, {bool startEditing = false}){
    debugPrint(note.text);
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (c){
              return FullPageEditorScreen(note, startEditing, books);
            }
        ));
  }

  @override
  Widget build(BuildContext context) {

    final add = [FlatButton(onPressed: _addNote, child: Text('ADD'))];

    return Scaffold(
      appBar: AppBar(
        title: Text("${books.Name_Book}"),
        actions: add,
      ),
      body: _getBody(),
    );
  }


  Widget _getBody() {

    Widget _buildNoteListTile(BuildContext context, int index){
      var note = _notes[index];

      return ListTile(
        onTap: () => _navigateToNoteDetails(note, index),
        title: Text(note.title),
        subtitle: Text(formatter.format(note.date)),
      );
    }

    if (_notes == null) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
          child: Column(
              children: <Widget>[
                Text( "Topics",
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
    } else if (_notes.length == 0) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
          child: Column(
              children: <Widget>[
                Text( "Topics",
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
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: ListView.builder(
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
      setState((){
        _loadNotes();
      });
  }

}



