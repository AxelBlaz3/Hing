// API
import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

const String kBaseUrl = 'http://192.168.1.48:4999';
const int kAPIVersion = 1;
const String kAPIPrefix = 'api/v$kAPIVersion';
const String kAPILoginRoute = '$kBaseUrl/$kAPIPrefix/user/login';
const String kAPISignupRoute = '$kBaseUrl/$kAPIPrefix/user/signup';
const String kAPINewRecipeRoute = '$kBaseUrl/$kAPIPrefix/recipe';
const String kAPIFeedRoute = '$kBaseUrl/$kAPIPrefix/feed';
const String kAPIGetCommentsRoute = '$kBaseUrl/$kAPIPrefix/comments';
const String kAPIGetRepliesRoute = '$kBaseUrl/$kAPIPrefix/comments/replies';
const String kAPILikeRecipeRoute = '$kBaseUrl/$kAPIPrefix/recipe/like';
const String kAPIUnLikeRecipeRoute = '$kBaseUrl/$kAPIPrefix/recipe/unlike';
const String kAPIAddRecipeToFavoritesRoute =
    '$kBaseUrl/$kAPIPrefix/recipe/favorite';
const String kAPIRemoveRecipeFromFavoritesRoute =
    '$kBaseUrl/$kAPIPrefix/recipe/unfavorite';
const String kAPIPostNewCommentRoute = '$kBaseUrl/$kAPIPrefix/comment';
const String kAPILikeCommentRoute = '$kBaseUrl/$kAPIPrefix/comment/like';
const String kAPIUnLikeCommentRoute = '$kBaseUrl/$kAPIPrefix/comment/unlike';
const String kAPIPostNewReplyRoute = '$kBaseUrl/$kAPIPrefix/comment/reply';

// Route names
const String kLoginRoute = '/login';
const String kSignupRoute = '/signup';
const String kHomeRoute = '/home';
const String kRecipeRoute = '/recipe';
const String kProfileRoute = '/profile';
const String kUploadRecipe = '/upload';
const String kEditProfileRoute = '/editProfile';
const String kResetPasswordRoute = '/resetpassword';
const String kOnboardingRoute = '/onboarding';
const String kCommentsRoute = '/comments';
const String kRepliesRoute = '/replies';
const String kDetailsRoute = '/details';

// Categories
const List<String> allCategories = <String>[
  "INDIAN",
  "CHINESE",
  "MEXICAN",
  "CONTINENTAL",
  "OTHERS"
];

const int kTotalCategories = 6;
List<String> getAllCategories(BuildContext context) => List.generate(
    kTotalCategories,
    (index) => index == 0
        ? S.of(context).indian
        : index == 1
            ? S.of(context).chinese
            : index == 2
                ? S.of(context).italian
                : index == 3
                    ? S.of(context).mexican
                    : index == 4
                        ? S.of(context).continental
                        : S.of(context).others);

List<String> getHomeCategories(BuildContext context) =>
    [S.of(context).all, ...getAllCategories(context)];

List<String> getQuantityUnits() =>
    ['gms', 'kg', 'ml', 'mg', 'litres', 'tbsp', 'pcs'];

const List<String> detailTabs = <String>[
  "DESCRIPTION",
  "INGREDIENTS",
];

// Hive types
const int kObjectIdType = 0;
const int kHingUserType = 1;
const int kIngredientType = 2;
const int kRecipeType = 3;
const int kMediaType = 4;
const int kCommentType = 5;
const int kTimestampType = 6;

// Hive boxes
const String kUserBox = 'userBox';

// Hive keys
const String kUserKey = 'userKey';
