import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  Note({
    required this.count,
    required this.notes,
  });

  int count;
  List<NoteElement> notes;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    count: json["count"],
    notes: List<NoteElement>.from(json["notes"].map((x) => NoteElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
  };
}

class NoteElement {
  NoteElement({
    required this.title,
    required this.content,
    required this.isDone,
    required this.id,
    required this.request,
  });

  String title;
  String content;
  bool isDone;
  String id;
  Request request;

  factory NoteElement.fromJson(Map<String, dynamic> json) => NoteElement(
    title: json["title"],
    content: json["content"],
    isDone: json["isDone"],
    id: json["id"],
    request: Request.fromJson(json["request"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "isDone": isDone,
    "id": id,
    "request": request.toJson(),
  };
}

class Request {
  Request({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };
}