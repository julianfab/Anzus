import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; //date

class Note{

  Note({@required this.title, @required this.text, @required this.date});


  //final int id;
  String title;
  String text;
  final DateTime date;
  static final String emptyText = '[{"insert":"\\n"}]';//be careful to use ' and not "



  static List<Note> allFromResponse(String response){

    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson["results"]
        .cast<Map<String, dynamic>>()
        .map((obj) => Note.fromMap(obj))
        .toList()
        .cast<Note>();
  }

  static Note fromMap(Map map){
    var textJson = json.encode(map['text']);//5
    return Note(title: map['title'], text: textJson, date: DateTime.parse(map['date']));
  }

  String toJson(){
    return json.encode({
      'title':this.title,
      'date':DateFormat('yyyy-MM-dd hh:mm:ss').format(this.date),
      'text':this.text,
    });
  }

  Map<String, dynamic> toMap() => {
    'title':this.title,
    'date':DateFormat('yyyy-MM-dd hh:mm:ss').format(this.date),
    'text':this.text
  };


  static Note fromJsonResponse(String response) {
    var decodedJson = json.decode(response);
    var casted = decodedJson.cast<String, dynamic>();
    return fromMap(casted);
  }

  void changeNoteTitle(String text) {
    this.title = text;
  }

}