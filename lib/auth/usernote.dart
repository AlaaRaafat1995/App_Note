import 'dart:convert';

class UserNote {
  String? title;
  String? note;
  String? imageurl;
  UserNote({
    this.title,
    this.note,
    this.imageurl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'imageurl': imageurl,
    };
  }

  factory UserNote.fromMap(Map<String, dynamic> map) {
    return UserNote(
      title: map['title'],
      note: map['note'],
      imageurl: map['imageurl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNote.fromJson(String source) =>
      UserNote.fromMap(json.decode(source));

  UserNote copyWith({
    String? title,
    String? note,
    String? imageurl,
  }) {
    return UserNote(
      title: title ?? this.title,
      note: note ?? this.note,
      imageurl: imageurl ?? this.imageurl,
    );
  }
}
