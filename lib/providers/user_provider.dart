import 'package:flutter/material.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider({required this.userRepository});

  Future<dynamic> login(
      {required String email, required String password}) async {
    return userRepository.login(email: email, password: password);
  }

  Future<dynamic> signup(
      {required String email,
      required String displayName,
      required String password}) async {
    return userRepository.signup(
        email: email, password: password, displayName: displayName);
  }

  Future<List<HingUser>> getFollowers({int page = 1, String? userId}) async {
    return await userRepository.getFollowers(page: page, userId: userId);
  }

  Future<List<HingUser>> getFollowing({int page = 1, String? userId}) async {
    return await userRepository.getFollowing(page: page, userId: userId);
  }

  Future<List<Recipe>> getFavorites({int page = 1, String? userId}) async {
    return await userRepository.getFavorites(page: page, userId: userId);
  }

  Future<List<Recipe>> getPosts({int page = 1, String? userId}) async {
    return await userRepository.getPosts(page: page, userId: userId);
  }

  Future<bool> followUser(
      {required String followeeId}) async {
    return await userRepository.followUser(followeeId: followeeId);
  }

  Future<bool> unFollowUser(
      {required String followeeId}) async {
    return await userRepository.unFollowUser(followeeId: followeeId);
  }
}
