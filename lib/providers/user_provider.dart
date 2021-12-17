import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/models/hing_notification/hing_notification.dart';
import 'package:hing/repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider({required this.userRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  XFile? _editProfileImage;

  XFile? get editProfileImage => _editProfileImage;
  bool _showNotificationBadge = false;

  void setShowNotificationBadge(bool newState) {
    _showNotificationBadge = newState;
    notifyListeners();
  }

  bool get shouldShowNotificationBadge => _showNotificationBadge;

  HingUser get currentUser => Hive.box<HingUser>(kUserBox).get(kUserKey)!;

  void setEditProfileImage(XFile? image) {
    _editProfileImage = image;
    notifyListeners();
  }

  void setIsLoading(bool newState, {bool notify = true}) {
    _isLoading = newState;
    if (notify) {
      notifyListeners();
    }
  }

  void notifyUserChanges() {
    notifyListeners();
  }

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

  Future<bool> sendVerificationCode({required String email}) async {
    return await userRepository.sendVerificationCode(email: email);
  }

  Future<bool> createNewPassword(
      {required String email,
      required String password,
      required String code}) async {
    return await userRepository.createNewPassword(
        email: email, password: password, code: code);
  }

  Future<List<HingUser>> getFollowers(
      {int page = 1, required String userId}) async {
    return await userRepository.getFollowers(page: page, userId: userId);
  }

  Future<List<HingUser>> getFollowing(
      {int page = 1, required String userId}) async {
    return await userRepository.getFollowing(page: page, userId: userId);
  }

  Future<List<Recipe>> getFavorites({int page = 1, String? userId}) async {
    return await userRepository.getFavorites(page: page, userId: userId);
  }

  Future<List<Recipe>> getPosts({int page = 1, String? userId}) async {
    return await userRepository.getPosts(page: page, userId: userId);
  }

  Future<bool> followUser({required String followeeId}) async {
    return await userRepository.followUser(followeeId: followeeId);
  }

  Future<bool> unFollowUser({required String followeeId}) async {
    return await userRepository.unFollowUser(followeeId: followeeId);
  }

  Future<List<HingNotification>> getNotifications(
      {int page = 1, int perPage = 10}) async {
    return await userRepository.getNotifications(page: page);
  }

  Future<bool> updateUser({required String displayName, XFile? image}) async {
    return await userRepository.updateUser(
        displayName: displayName, image: image);
  }

  Future<bool> updateFirebaseToken({required String firebaseToken}) async {
    return await userRepository.updateFirebaseToken(
        firebaseToken: firebaseToken);
  }

  Future<bool> updateMyIngredients(
      {required String recipeId, required List<String> myIngredients}) async {
    return await userRepository.updateMyIngredients(
        recipeId: recipeId, ingredients: myIngredients);
  }

  void updateReportedRecipes(Recipe recipe) async {
    final List<String> reportedRecipeIds =
        Set<String>.from(currentUser.reportedRecipeIds ?? []..add(recipe.id.oid)).toList();

    await Hive.box<HingUser>(kUserBox).put(
        kUserKey,
        currentUser.copy(
            reportedRecipeIds: reportedRecipeIds));
    notifyListeners();
  }

  Future<dynamic> changePassword({required String userId,required String password,required String oldPassword})async{
    return await userRepository.changePassword(userId: userId, password: password,oldPassword: oldPassword);
  }

  Future<bool> blockUser({required String userId,required String blockUserId})async{
    return await userRepository.blockUser(userId: userId, blockUserId: blockUserId);
}
}
