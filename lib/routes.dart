import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/comments/comments.dart';
import 'package:hing/screens/details/components/ingredients_list_item.dart';
import 'package:hing/screens/details/details.dart';
import 'package:hing/screens/details/my_shopping_list.dart';
import 'package:hing/screens/editprofile/editprofile.dart';
import 'package:hing/screens/home/home.dart';
import 'package:hing/screens/login/login.dart';
import 'package:hing/screens/newrecipe/components/ingredients_item.dart';
import 'package:hing/screens/newrecipe/new_recipe.dart';
import 'package:hing/screens/notifications/notifications.dart';
import 'package:hing/screens/onboarding/onboarding.dart';
import 'package:hing/screens/profile/my_profile.dart';
import 'package:hing/screens/profile/profile.dart';
import 'package:hing/screens/replies/replies.dart';
import 'package:hing/screens/resetpassword/create_password_screen.dart';
import 'package:hing/screens/resetpassword/reset_password_screen.dart';
import 'package:hing/screens/search/search_screen.dart';
import 'package:hing/screens/signup/signup.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case kOnBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => OnboardingScreen(index: settings.arguments as int));
      case kLoginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case kSignupRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case kHomeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case kDetailsRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => DetailsScreen());
      case kUploadRecipe:
        return MaterialPageRoute(builder: (_) => NewRecipeScreen());
      case kShoppingList:
        return MaterialPageRoute(
            builder: (_) => IngredientsListItem1(
                  recipe: settings.arguments as Recipe,
                  ingredient: (settings.arguments as Ingredient),
                  //myIngredients: <String>[],
                ));
      case kRepliesRoute:
        return MaterialPageRoute(
            builder: (_) => RepliesScreen(
                  recipe: (settings.arguments!
                      as Map<String, dynamic>)['recipe'] as Recipe,
                  comment: (settings.arguments!
                      as Map<String, dynamic>)['comment'] as Comment,
                  isReply: (settings.arguments!
                          as Map<String, dynamic>)['is_reply'] as bool? ??
                      false,
                  refreshCallback: (settings.arguments!
                      as Map<String, dynamic>)['refresh_callback'],
                ));
      case kCommentsRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => CommentsScreen(
                recipe: (settings.arguments as Map<String, dynamic>)['recipe']
                    as Recipe,
                refreshCallback: (settings.arguments
                    as Map<String, dynamic>)['refresh_callback']));
      case kResetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case kProfileRoute:
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  user: settings.arguments as HingUser,
                ));
      case kMyProfileRoute:
        return MaterialPageRoute(
            builder: (_) => MyProfileScreen(
                  user: settings.arguments as HingUser,
                ));
      case kEditProfileRoute:
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  user: settings.arguments as HingUser,
                ));
      case kNotificationRoute:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case kCreatePasswordRoute:
        return MaterialPageRoute(
            builder: (_) =>
                CreatePasswordScreen(email: settings.arguments as String));
      case kSearchRoute:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        throw Exception(
            'Unknown route ${settings.name}. Make sure to add the route to RouteGenerator before navigating.');
    }
  }
}
