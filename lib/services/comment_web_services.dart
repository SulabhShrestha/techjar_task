import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:techjar_task/models/comment_model.dart';
import 'package:techjar_task/utils/app_url.dart';

class CommentWebServices {
  final dio = Dio();

  Future<void> addComment(Map<String, dynamic> details, String postId) async {
    log("comment details $details");
    try {
      await dio.post(
        AppUrl.commentsForPost(postId),
        data: details,
      );
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }

  Future<List<CommentModel>> getAllCommentsForPost(String postId) async {
    try {
      final response = await dio.get(AppUrl.commentsForPost(postId));

      List<dynamic> data = response.data;

      List<CommentModel> comments = [];

      for (var post in data) {
        comments.add(CommentModel.fromMap(post));
      }

      return comments;
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }
}
