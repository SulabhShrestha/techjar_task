// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  int postId;
  int id;
  String name;
  String email;
  String body;
  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  CommentModel copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return CommentModel(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(postId: $postId, id: $id, name: $name, email: $email, body: $body)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.postId == postId &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.body == body;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      body.hashCode;
  }
}
