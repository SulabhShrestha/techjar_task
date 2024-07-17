
import 'package:techjar_task/models/post_model.dart';
import 'package:techjar_task/services/post_web_services.dart';

class PostViewModel {
  final PostWebServices _postWebServices = PostWebServices();

  // Returning all posts in the form of List<PostModel>
  Future<List<PostModel>> getAllPosts() async {
    try {
      // To be returned this
      List<PostModel> postModels = [];

      // Getting all posts and converting all to model
      List<dynamic> allPosts = await _postWebServices.getAllPosts();
      for (var post in allPosts) {
        postModels.add(PostModel.fromMap(post));
      }

      // Returning the list of post models
      return postModels;
    } catch (e) {
      rethrow;
    }
  }
}
