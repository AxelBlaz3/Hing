import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';
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

  void notifyCommentChanges() {
    notifyListeners();
  }

  Future<List<Comment>> getCommentsForRecipe(
      {required String recipeId, int page = 1}) async {
    return await recipeRepository.getCommentsForRecipe(
        recipeId: recipeId, page: page);
  }

  Future<List<Comment>> getRepliesForComment(
      {required String commentId, int page = 1}) async {
    return await recipeRepository.getRepliesForComment(
        commentId: commentId, page: page);
  }

  Future<Comment?> postNewComment(
      {required String recipeId, required String body}) async {
    return await recipeRepository.postNewComment(
        recipeId: recipeId, body: body);
  }

  Future<Comment?> postNewReply(
      {required String commentId,
      required String recipeId,
      required bool isCommentReply,
      required String body}) async {
    return await recipeRepository.postNewReply(
        commentId: commentId, body: body, recipeId: recipeId, isCommentReply: isCommentReply);
  }

  Future<bool> likeComment({required String commentId}) async {
    return await recipeRepository.likeComment(commentId: commentId);
  }

  Future<bool> unLikeComment({required String commentId}) async {
    return await recipeRepository.unLikeComment(commentId: commentId);
  }

  Future<bool> likeReply({required String commentId}) async {
    return await recipeRepository.likeReply(commentId: commentId);
  }

  Future<bool> unLikeReply({required String commentId}) async {
    return await recipeRepository.unLikeReply(commentId: commentId);
  }
}
