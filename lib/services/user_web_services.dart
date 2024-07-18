import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:techjar_task/utils/app_url.dart';

class UserWebServices {
  final dio = Dio(); 
  Future<List<dynamic>> getAllUser() async {
    try {
      final response = await dio.get(
        AppUrl.allUsers,
      );

      return response.data;
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String uid) async {
    try {
      final response = await dio.get(
        "${AppUrl.allUsers}/$uid",
      );

      var data = response.data;
      return {
        'name': data['name'],
        'email': data['email'],
      };
    } catch (e) {
      rethrow;
    }
  }
}
