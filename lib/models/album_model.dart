// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlbumModel {
  final String title;
  final int userId;
  final int id;
  AlbumModel({
    required this.title,
    required this.userId,
    required this.id,
  });

  

  AlbumModel copyWith({
    String? title,
    int? userId,
    int? id,
  }) {
    return AlbumModel(
      title: title ?? this.title,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'userId': userId,
      'id': id,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      title: map['title'] as String,
      userId: map['userId'] as int,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(String source) => AlbumModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AlbumModel(title: $title, userId: $userId, id: $id)';

  @override
  bool operator ==(covariant AlbumModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.userId == userId &&
      other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ userId.hashCode ^ id.hashCode;
}
