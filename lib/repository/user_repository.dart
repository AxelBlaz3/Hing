import 'dart:convert';
import 'dart:io';

import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
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

  Future<List<HingUser>> getFollowers({int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetFollowersRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page'));
      if (response.statusCode == HttpStatus.ok) {
        final List data = jsonDecode(response.body);
        final List<HingUser> users =
            List<HingUser>.from(data.map((user) => HingUser.fromJson(user)));
        return users;
      }
    } catch (e) {}
    return [];
  }

  Future<List<HingUser>> getFollowing({int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetFollowingRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page'));
      if (response.statusCode == HttpStatus.ok) {
        final List data = jsonDecode(response.body);
        final List<HingUser> users =
            List<HingUser>.from(data.map((user) => HingUser.fromJson(user)));
        return users;
      }
    } catch (e) {}
    return [];
  }

  Future<List<Recipe>> getFavorites({int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetFavoritesRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page'));
      if (response.statusCode == HttpStatus.ok) {
        final List data = jsonDecode(response.body);
        final List<Recipe> recipes =
            List<Recipe>.from(data.map((recipe) => Recipe.fromJson(recipe)));
        return recipes;
      }
    } catch (e) {}
    return [];
  }

  Future<List<Recipe>> getPosts({int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetPostsRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page'));
      if (response.statusCode == HttpStatus.ok) {
        final List data = jsonDecode(response.body);
        final List<Recipe> recipes =
            List<Recipe>.from(data.map((recipe) => Recipe.fromJson(recipe)));
        return recipes;
      }
    } catch (e) {
      print('Exception occured when fetching posts - $e');
    }
    return [];
  }

  Future<bool> followUser({required String followeeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIFollowUserRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'followee_id': followeeId,
            'follower_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> unFollowUser({required String followeeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUnFollowUserRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'followee_id': followeeId,
            'follower_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }
}
