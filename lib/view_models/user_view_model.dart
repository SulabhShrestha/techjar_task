import 'dart:developer';

import 'package:techjar_task/models/user_model.dart';
import 'package:techjar_task/services/user_web_services.dart';

class UserViewModel {
  final UserWebServices _userWebServices = UserWebServices();

  Future<List<UserModel>> getAllUser() async {
    try {
      final allUsers = await _userWebServices.getAllUser();

      List<UserModel> userModels = [];
      for (var user in allUsers) {
        userModels.add(UserModel.fromMap(user));
      }
      return userModels;
    } catch (e) {

      log("Error: $e");
      
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String uid) async {
    try {
      final userDetails = await _userWebServices.fetchUserDetails(uid);
      return userDetails;
    } catch (e) {
      rethrow;
    }
  }
}
