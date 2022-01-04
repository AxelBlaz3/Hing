import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_notification/hing_notification.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

        await Hive.box<HingUser>(kUserBox).put(kUserKey, hingUser);
        // Update firebase token and cache logged in user.

        final String? firebaseToken =
            await FirebaseMessaging.instance.getToken();

        if (firebaseToken != null) {
          await updateFirebaseToken(firebaseToken: firebaseToken);
        }
        return hingUser;
      } else
        return response.statusCode;
    } on SocketException {
      return SOCKET_EXCEPTION_CODE;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> signup(
      {required String displayName,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(Uri.parse(kAPISignupRoute),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(<String, String>{
            'email': email,
            'display_name': displayName,
            'password': password
          }));

      if (response.statusCode == HttpStatus.created) {
        print(response.body);
        final hingUser = HingUser.fromJson(jsonDecode(response.body));

        await Hive.box<HingUser>(kUserBox).put(kUserKey, hingUser);
        // Update firebase token and cache signed up user.
        final String? firebaseToken =
            await FirebaseMessaging.instance.getToken();

        if (firebaseToken != null) {
          await updateFirebaseToken(firebaseToken: firebaseToken);
        }
        return hingUser;
      } else {
        return response.statusCode;
      }
    } on SocketException catch (error) {
      print(error);
      return SOCKET_EXCEPTION_CODE;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> sendVerificationCode({required String email}) async {
    try {
      final response = await http.post(
          Uri.parse(kAPISendVerificationEmailRoute),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(<String, String>{'email': email}));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> createNewPassword(
      {required String email,
      required String password,
      required String code}) async {
    try {
      final response = await http.put(Uri.parse(kAPICreatePasswordRoute),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
            'code': code
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<List<HingUser>> getFollowers({int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetFollowersRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page&other_user_id=${user!.id.oid}'));
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
          '${kAPIGetFollowingRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page&other_user_id=${user!.id.oid}'));
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
          '${kAPIGetPostsRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page&other_user_id=${user!.id.oid}'));
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

  Future<List<HingNotification>> getNotifications(
      {int page = 1, String? userId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '${kAPIGetNotificationsRoute.replaceFirst('{}', userId ?? user!.id.oid)}?page=$page'));
      if (response.statusCode == HttpStatus.ok) {
        final List data = jsonDecode(response.body);
        final List<HingNotification> recipes = List<HingNotification>.from(
            data.map((recipe) => HingNotification.fromJson(recipe)));
        return recipes;
      }
    } catch (e) {
      print('Exception occured when fetching notifications - $e');
    }
    return [];
  }

  Future<bool> updateUser({required String displayName, XFile? image}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final request =
          http.MultipartRequest('PUT', Uri.parse(kAPIUpdateUserRoute));

      request
        ..fields['display_name'] = displayName
        ..fields['user_id'] = user!.id.oid;

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }

      final response = await request.send();
      if (response.statusCode == HttpStatus.ok) {
        // Update cached user 'image' with new image.
        final responseBody = jsonDecode(await response.stream.bytesToString());
        final HingUser cachedUser = Hive.box<HingUser>(kUserBox).get(kUserKey)!;
        Hive.box<HingUser>(kUserBox).put(
            kUserKey,
            cachedUser
              ..image = responseBody['image']
              ..displayName = displayName);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> updateFirebaseToken({required String firebaseToken}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUpdateFirebaseTokenRoute),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(<String, String>{
            'firebase_token': firebaseToken,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
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

  Future<bool> updateMyIngredients(
      {required String recipeId, required List<String> ingredients}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUpdateMyIngredientsRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'recipe_id': recipeId,
            'user_id': user!.id.oid,
            'ingredients': ingredients
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword({
    required String userId,
    required String password,
    required String oldPassword,
  }) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIChangePasswordRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'user_id': user!.id.oid,
            'new_password': password,
            "old_password": oldPassword
          }));
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      return false;
    }
  }

  Future<bool> blockUser(
      {required String userId, required String blockUserId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIBlockUserRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'user_id': user!.id.oid,
            'other_user_id': blockUserId
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      return false;
    }
  }

//new
  Future<bool> deleteUserPost({required String recipeId}) async {
    try {
      print(kAPIDeletePost);
      final response = await http.delete(Uri.parse(kAPIDeletePost),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'recipe_id': recipeId,
          }));
      print(response.statusCode == 200);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
