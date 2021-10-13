import 'dart:convert';
import 'dart:io';

import 'package:hing/constants.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RecipeRepository {
  Future<bool> createNewRecipe(Map<String, dynamic> recipe, XFile? file) async {
    final request =
        http.MultipartRequest('POST', Uri.parse(kAPINewRecipeRoute));

    for (final item in recipe.entries) {
      request.fields[item.key] = '${item.value}';
    }
    // recipe.entries
    //     .map((formData) => request.fields[formData.key] = formData.value);
    request.files.add(await http.MultipartFile.fromPath('media', file!.path));

    final response = await request.send();
    // final response = await http.post(Uri.parse(kAPINewRecipeRoute), body: recipe);
    return response.statusCode == HttpStatus.created;
  }

  Future<List<Recipe>> getFeedForCategory(
      {int category = 0, int page = 1}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '$kAPIFeedRoute/${user?.id.oid}?page=$page&category=$category'));

      if (response.statusCode == HttpStatus.ok) {
        final List body = jsonDecode(response.body);
        final List<Recipe> recipes = List<Recipe>.from(
            body.map((recipeJson) => Recipe.fromJson(recipeJson)).toList());
        return recipes;
      } else
        return <Recipe>[];
    } catch (e) {
      print(e);
    }
    return <Recipe>[];
  }

  Future<List<Comment>> getCommentsForRecipe(
      {required String recipeId, int page = 1}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '$kAPIGetCommentsRoute/$recipeId?user_id=${user?.id.oid}&page=$page'));

      if (response.statusCode == HttpStatus.ok) {
        final List commentsJson = jsonDecode(response.body);
        final List<Comment> comments = List<Comment>.from(
            commentsJson.map((comment) => Comment.fromJson(comment))).toList();

        return comments;
      }
    } catch (e) {
      print('Exception occured when fetching comments - $e');
    }
    return <Comment>[];
  }

  Future<List<Comment>> getRepliesForComment(
      {required String commentId, int page = 1}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '$kAPIGetRepliesRoute/$commentId?user_id=${user?.id.oid}&page=$page'));

      if (response.statusCode == HttpStatus.ok) {
        final List repliesJson = jsonDecode(response.body);
        final List<Comment> replies = List<Comment>.from(
            repliesJson.map((reply) => Comment.fromJson(reply))).toList();

        return replies;
      }
    } catch (e) {
      print('Exception occured when fetching comments - $e');
    }
    return <Comment>[];
  }

  Future<Comment?> postNewComment(
      {required String recipeId, required String body}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.post(Uri.parse(kAPIPostNewCommentRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'body': body,
            'user_id': user!.id.oid,
            'recipe_id': recipeId
          }));

      if (response.statusCode == HttpStatus.created) {
        final Comment _comment = Comment.fromJson(jsonDecode(response.body));
        return _comment;
      }
    } catch (e) {
      print('Comment exception - $e');
    }
  }

  Future<Comment?> postNewReply(
      {required String commentId,
      required String recipeId,
      required bool isCommentReply,
      required String body}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.post(Uri.parse(kAPIPostNewReplyRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'body': body,
            'user_id': user!.id.oid,
            'recipe_id': recipeId,
            'is_comment_reply': isCommentReply,
            'comment_id': commentId
          }));

      if (response.statusCode == HttpStatus.created) {
        final Comment reply = Comment.fromJson(jsonDecode(response.body));
        return reply;
      }
    } catch (e) {
      print('Reply exception - $e');
    }
  }

  Future<bool> addRecipeToFavorites({required String recipeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIAddRecipeToFavoritesRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'recipe_id': recipeId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> removeRecipeFromFavorites({required String recipeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(
          Uri.parse(kAPIRemoveRecipeFromFavoritesRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'recipe_id': recipeId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> likeRecipe({required String recipeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPILikeRecipeRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'recipe_id': recipeId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> unLikeRecipe({required String recipeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUnLikeRecipeRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'recipe_id': recipeId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> likeComment({required String commentId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPILikeCommentRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'comment_id': commentId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> unLikeComment({required String commentId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUnLikeCommentRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'comment_id': commentId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<bool> likeReply({required String commentId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPILikeReplyRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'reply_id': commentId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> unLikeReply({required String commentId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.put(Uri.parse(kAPIUnLikeReplyRoute),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(<String, String>{
            'reply_id': commentId,
            'user_id': user!.id.oid
          }));

      return response.statusCode == HttpStatus.ok;
    } catch (e) {}
    return false;
  }

  Future<File?> getRecipeImage(String imageUrl) async {
    try {
      final response = await http.get((Uri.parse(imageUrl)));

      final documentDirectory = (await getExternalStorageDirectory())!.path;
      File imgFile = new File('$documentDirectory/recipe_image.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      return imgFile;
    } catch (e) {}
  }

  Future<Recipe?> getRecipe({required String recipeId}) async {
    try {
      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      final response = await http.get(Uri.parse(
          '$kAPIGetRecipeRoute?recipe_id=$recipeId&user_id=${user?.id.oid}'));

      if (response.statusCode == 200) {
        final Recipe recipe = Recipe.fromJson(jsonDecode(response.body));
        return recipe;
      }
    } catch (e) {
      print(e);
    }
  }
}
