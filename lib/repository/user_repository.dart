import 'dart:convert';
import 'dart:io';

import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse(kAPILoginRoute),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == HttpStatus.ok) {
        final hingUser = HingUser.fromJson(jsonDecode(response.body));
        // Cache logged in user
        await Hive.box<HingUser>(kUserBox).put(kUserKey, hingUser);
        return hingUser;
      } else
        return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> signup(
      {required String displayName,
      required String email,
      required String password}) async {
    final response = await http.post(Uri.parse(kAPISignupRoute),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(<String, String>{
          'email': email,
          'display_name': displayName,
          'password': password
        }));

    if (response.statusCode == HttpStatus.created) {
      final hingUser = HingUser.fromJson(jsonDecode(response.body));
      // Cache logged in user
      await Hive.box<HingUser>(kUserBox).put(kUserKey, hingUser);
      return hingUser;
    } else
      return response.statusCode;
  }
}
