import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/reply/reply.dart';
import 'package:hing/repository/recipe_repository.dart';

class CommentProvider extends ChangeNotifier {
  final RecipeRepository recipeRepository;

  bool _isCommentEmpty = true;

  bool get isCommentEmpty => _isCommentEmpty;

  void setIsCommentEmpty(bool newState) {
    _isCommentEmpty = newState;
    notifyListeners();
  }

  CommentProvider({required this.recipeRepository});

  Future<List<Comment>> getCommentsForRecipe(
      {required String recipeId, int page = 1}) async {
    return await recipeRepository.getCommentsForRecipe(
        recipeId: recipeId, page: page);
  }

  Future<List<Reply>> getRepliesForComment(
      {required String commentId, int page = 1}) async {
    return await recipeRepository.getRepliesForComment(
        commentId: commentId, page: page);
  }

  Future<Comment?> postNewComment(
      {required String recipeId, required String body}) async {
    return await recipeRepository.postNewComment(
        recipeId: recipeId, body: body);
  }
}
