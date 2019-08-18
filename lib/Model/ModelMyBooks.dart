import 'dart:convert';

MyBooks bookFromJson(String str) {
  final jsonData = json.decode(str);
  return MyBooks.fromMap(jsonData);
}

String bookToJson(MyBooks data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class MyBooks {
  static final String NAME_TABLE = 'My_Books';
  int id;
  String Name_Book;

  MyBooks({
    this.id,
    this.Name_Book
  });

  factory MyBooks.fromMap(Map<String, dynamic> json) => new MyBooks(
    id: json["id"],
    Name_Book: json["Name_Book"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Name_Book": Name_Book,
  };

}