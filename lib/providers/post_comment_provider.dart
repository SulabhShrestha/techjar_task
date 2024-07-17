import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techjar_task/models/comment_model.dart';

/// stores the state of the comments of all posts
final postCommentsProvider =
    StateNotifierProvider<PostCommentsProvider, List<CommentModel>>(
        (ref) => PostCommentsProvider());

class PostCommentsProvider extends StateNotifier<List<CommentModel>> {
  PostCommentsProvider() : super([]);

  void addComment(CommentModel comment) {
    log("adding");
    state = [comment, ...state];
  }

  void addAllComments(List<CommentModel> comments) {
    state = [...state, ...comments];
  }
}
