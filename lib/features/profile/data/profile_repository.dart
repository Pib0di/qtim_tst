// /features/profile/data/profile_repository.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:qtim_tst/data/models/user.dart';

class ProfileRepository {
  ProfileRepository();

  Future<User?> getUser() async {
    try {
      final jsonString = await rootBundle.loadString('assets/user_data.json');
      final jsonData = jsonDecode(jsonString);
      final userFromJson = User.fromJson(jsonData);
      print('userFromJson:${userFromJson}');
      return userFromJson;
    } catch (e) {
      return null;
    }
  }
}
