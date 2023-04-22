import 'dart:convert';

NoteContent noteContentFromJson(String str) => NoteContent.fromJson(json.decode(str));

String noteContentToJson(NoteContent data) => json.encode(data.toJson());

class NoteContent {
  NoteContent({
    required this.title,
    required this.content,
  });

  String title;
  String content;

  factory NoteContent.fromJson(Map<String, dynamic> json) => NoteContent(
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}