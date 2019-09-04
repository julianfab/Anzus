import 'dart:convert';

Topics bookFromJson(String str) {
  final jsonData = json.decode(str);
  return Topics.fromMap(jsonData);
}

String bookToJson(Topics data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Topics {
  static final String NAME_TABLE = 'Topics_Book';
  int id;
  String Name_Topic;

  Topics({
    this.id,
    this.Name_Topic
  });

  factory Topics.fromMap(Map<String, dynamic> json) => new Topics(
    id: json["id"],
    Name_Topic: json["Name_Topic"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Name_Topic": Name_Topic,
  };

}