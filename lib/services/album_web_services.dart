import 'package:dio/dio.dart';
import 'package:techjar_task/utils/app_url.dart';

/// handles the fetching of albums and photos
class AlbumWebServices {
  final dio = Dio();

  Future<List<dynamic>> fetchAlbums() async {
    try {
      // fetching albums of userid 2 only

      final response = await dio.get("${AppUrl.allUsers}/2/albums");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchPhotos(int albumId) async {
    try {
      final response = await dio.get("${AppUrl.allAlbums}/$albumId/photos");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
