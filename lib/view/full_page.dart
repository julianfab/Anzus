import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anzus/Database/DataBaseSQL.dart';
import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:anzus/Model/ModelTopics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:path/path.dart' as p;
import '../Model/note.dart';

DataBaseHelperSQL _helperDB = new DataBaseHelperSQL();
class ZefyrLogo extends StatelessWidget {

  final String title;
  ZefyrLogo({this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title)
      ],
    );
  }
}

class FullPageEditorScreen extends StatefulWidget {

  FullPageEditorScreen(this.note, this.openOnEditing, this.book);
  final MyBooks book;
  final Note note;
  final bool openOnEditing;

  @override
  _FullPageEditorScreenState createState() => _FullPageEditorScreenState(book,note);
}

/*final doc =
    r'[{"insert":"Zefyr"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Soft and gentle rich text editing for Flutter applications.","attributes":{"i":true}},{"insert":"\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"asset://assets/breeze.jpg"}}},{"insert":"\n"},{"insert":"Photo by Hiroyuki Takeda.","attributes":{"i":true}},{"insert":"\nZefyr is currently in "},{"insert":"early preview","attributes":{"b":true}},{"insert":". If you have a feature request or found a bug, please file it at the "},{"insert":"issue tracker","attributes":{"a":"https://github.com/memspace/zefyr/issues"}},{"insert":'
    r'".\nDocumentation"},{"insert":"\n","attributes":{"heading":3}},{"insert":"Quick Start","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/quick_start.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Data Format and Document Model","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/data_and_document.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Style Attributes","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/attr'
    r'ibutes.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Heuristic Rules","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/heuristics.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"FAQ","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/faq.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Clean and modern look"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Zefyr’s rich text editor is built with simplicity and fle'
    r'xibility in mind. It provides clean interface for distraction-free editing. Think Medium.com-like experience.\nMarkdown inspired semantics"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Ever needed to have a heading line inside of a quote block, like this:\nI’m a Markdown heading"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"And I’m a regular paragraph"},{"insert":"\n","attributes":{"block":"quote"}},{"insert":"Code blocks"},{"insert":"\n","attributes":{"headin'
    r'g":2}},{"insert":"Of course:\nimport ‘package:flutter/material.dart’;"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"import ‘package:zefyr/zefyr.dart’;"},{"insert":"\n\n","attributes":{"block":"code"}},{"insert":"void main() {"},{"insert":"\n","attributes":{"block":"code"}},{"insert":" runApp(MyWAD());"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"}"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"\n\n\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}*/

class _FullPageEditorScreenState extends State<FullPageEditorScreen> {
  _FullPageEditorScreenState(this.book,this.note);
  final MyBooks book;
  final Note note;
  String titleE;
  Directory dir;
  ZefyrController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _editing = false;
  StreamSubscription<NotusChange> _sub;
  TextEditingController _titleController;
  @override
  void initState(){
    super.initState();
    print(note.text);
    titleE= note.title;
    _controller = ZefyrController(NotusDocument.fromDelta(
        Delta.fromJson(json.decode(note.text) as List)));//1
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
    _titleController = new TextEditingController(text: note.title);
    _titleController.addListener(_editTitle);

    if (widget.openOnEditing){
      _startEditing();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sub.cancel();
    super.dispose();
  }

  void _editTitle() {
    var text = _titleController.text;
    if (text.isEmpty) {
      setState(() {
        widget.note.changeNoteTitle('Untitled');
      });
    } else {
      setState(() {
        widget.note.changeNoteTitle(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = ZefyrThemeData(
      cursorColor: Colors.red,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.grey,
        disabledIconColor: Colors.grey.shade500,
      )
    );

    final done = _editing
        ? [FlatButton(onPressed: _stopEditing, child: Text('DONE'))]
        : [FlatButton(onPressed: (){
            writeCounter();
          }, child: Text("GUARDAR")),FlatButton(onPressed: _startEditing, child: Text('EDIT')),];

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        brightness: Brightness.dark,
        title: TextField(
          controller: _titleController,
          autofocus: false,
          enabled: _editing,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          cursorColor: Colors.white,
          style: new TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.black,
          ),
        ),
        actions: done,
      ),
      body: ZefyrScaffold(
        child: ZefyrTheme(
            data: theme,
            child: ZefyrEditor(
                controller: _controller,
                focusNode: _focusNode,
                enabled: _editing,
                imageDelegate: CustomImageDelegate(),
            )
        ),
      ),
    );
  }

  void _startEditing(){
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }

  writeCounter()  async{
    final jsonValue = jsonEncode(_controller.document.toJson());
    var noteCopy = widget.note;
    noteCopy.text = jsonValue;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir =  directory;
      Map<String, dynamic> fd;
      File jsonFile = File(dir.path+'/'+'Topic'+widget.book.Name_Book+'.json');
      fd = json.decode(jsonFile.readAsStringSync());
      print(noteCopy.date);
      fd['results'].add(noteCopy.toMap());
      bool fileExists = jsonFile.existsSync();
      print(noteCopy.toMap());
      if (fileExists){
        jsonFile.writeAsStringSync(json.encode(fd));
      }
    });
    // Write the file
  }

}

class CustomImageDelegate extends ZefyrDefaultImageDelegate {
  @override
  Widget buildImage(BuildContext context, String imageSource) {
    // TODO: implement buildImage
    if (imageSource.startsWith('asset://')){
      final asset = AssetImage(imageSource.replaceFirst('asset://', ''));
      return Image(image: asset,);
    } else {
      return super.buildImage(context, imageSource);
    }
  }
}

