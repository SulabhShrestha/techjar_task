import 'package:techjar_task/models/comment_model.dart';
import 'package:techjar_task/services/comment_web_services.dart';

class CommentViewModel {
  final CommentWebServices _commentWebServices = CommentWebServices();

  // Returning all comments for a post in the form of List<PostModel>
  Future<void> addComment(
      {required Map<String, dynamic> details, required String postID}) async {
    try {
      await _commentWebServices.addComment(details, postID);
    } catch (e) {
      rethrow;
    }
  }

  // Returning all comments for a post in the form of List<PostModel>
  Future<List<CommentModel>> getAllCommentsForPost(String postId) async {
    try {
      // To be returned this
      List<CommentModel> commentModels = [];

      // Getting all comments for a post and converting all to model
      List<dynamic> allComments =
          await _commentWebServices.getAllCommentsForPost(postId);
      for (var comment in allComments) {
        commentModels.add(CommentModel.fromMap(comment));
      }

      // Returning the list of comment models
      return commentModels;
    } catch (e) {
      rethrow;
    }
  }
}
