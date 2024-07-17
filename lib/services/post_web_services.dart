import 'package:dio/dio.dart';
import 'package:techjar_task/models/post_model.dart';
import 'package:techjar_task/utils/app_url.dart';

class PostWebServices {
  final dio = Dio();

  Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await dio.get(AppUrl.allPosts);
      List<dynamic> data = response.data;

      List<PostModel> posts = [];

      for (var post in data) {
        posts.add(PostModel.fromMap(post));
      }

      return posts;
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }
}
