import 'package:dio/dio.dart';
import 'package:techjar_task/utils/app_url.dart';

class PostWebServices {
  final dio = Dio();

  Future<List<dynamic>> getAllPosts() async {
    try {
      final response = await dio.get(AppUrl.allPosts);
      List<dynamic> data = response.data;

      return data;
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }
}
