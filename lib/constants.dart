// API
import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

// Shared preferences keys
const String kOnBoardingPrefKey = 'HING.ONBOARDING_KEY';

// Email regex.
final emailRegexPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

// const String kBaseUrl = 'http://192.168.50.196:5050';
const String kBaseUrl = 'https://hing.wielabs.tech';
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
const String kAPILikeReplyRoute = '$kBaseUrl/$kAPIPrefix/comment/reply/like';
const String kAPIUnLikeReplyRoute =
    '$kBaseUrl/$kAPIPrefix/comment/reply/unlike';
const String kAPIPostNewReplyRoute = '$kBaseUrl/$kAPIPrefix/comment/reply';
const String kAPIGetFollowingRoute = '$kBaseUrl/$kAPIPrefix/user/{}/following';
const String kAPIGetFollowersRoute = '$kBaseUrl/$kAPIPrefix/user/{}/followers';
const String kAPIGetNotificationsRoute =
    '$kBaseUrl/$kAPIPrefix/user/{}/notifications';
const String kAPIGetFavoritesRoute = '$kBaseUrl/$kAPIPrefix/user/{}/favorites';
const String kAPIGetPostsRoute = '$kBaseUrl/$kAPIPrefix/user/{}/posts';
const String kAPIFollowUserRoute = '$kBaseUrl/$kAPIPrefix/user/follow';
const String kAPIUnFollowUserRoute = '$kBaseUrl/$kAPIPrefix/user/unfollow';
const String kAPIUpdateUserRoute = '$kBaseUrl/$kAPIPrefix/user/update';
const String kAPISendVerificationEmailRoute =
    '$kBaseUrl/$kAPIPrefix/user/send/resetcode';
const String kAPICreatePasswordRoute =
    '$kBaseUrl/$kAPIPrefix/user/create/password';
const String kAPIUpdateFirebaseTokenRoute =
    '$kBaseUrl/$kAPIPrefix/user/update/token';
const String kAPIGetRecipeRoute = '$kBaseUrl/$kAPIPrefix/recipe';

// Route names
const String kLoginRoute = '/login';
const String kSignupRoute = '/signup';
const String kHomeRoute = '/home';
const String kRecipeRoute = '/recipe';
const String kProfileRoute = '/profile';
const String kMyProfileRoute = '/myProfile';
const String kUploadRecipe = '/upload';
const String kEditProfileRoute = '/editProfile';
const String kResetPasswordRoute = '/resetPassword';
const String kOnBoardingRoute = '/onboarding';
const String kCommentsRoute = '/comments';
const String kRepliesRoute = '/replies';
const String kDetailsRoute = '/details';
const String kNotificationRoute = '/notifications';
const String kCreatePasswordRoute = '/createPassword';

// Categories
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

const int kTotalProfileCategories = 4;
List<String> getMyProfileTabTitles(BuildContext context) => <String>[
      S.of(context).posts,
      S.of(context).favorites,
      S.of(context).followers,
      S.of(context).following
    ];

List<String> getQuantityUnits() =>
    ['gms', 'kg', 'ml', 'mg', 'litres', 'tbsp', 'pcs'];

// Hive types
const int kObjectIdType = 0;
const int kHingUserType = 1;
const int kIngredientType = 2;
const int kRecipeType = 3;
const int kMediaType = 4;
const int kCommentType = 5;
const int kTimestampType = 6;
const int kHingNotificationType = 7;
const int kCommentNotificationType = 8;
const int kRecipeNotificationType = 9;

// Hive boxes
const String kUserBox = 'userBox';

// Hive keys
const String kUserKey = 'userKey';
