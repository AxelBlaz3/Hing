import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/comments/comments.dart';
import 'package:hing/screens/details/details.dart';
import 'package:hing/screens/editprofile/editprofile.dart';
import 'package:hing/screens/home/home.dart';
import 'package:hing/screens/login/login.dart';
import 'package:hing/screens/newrecipe/new_recipe.dart';
import 'package:hing/screens/profile/profile.dart';
import 'package:hing/screens/replies/replies.dart';
import 'package:hing/screens/resetpassword/reset_password.dart';
import 'package:hing/screens/signup/signup.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
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
      case kRepliesRoute:
        return MaterialPageRoute(
            builder: (_) => RepliesScreen(
              recipe: (settings.arguments! as Map<String, dynamic>)['recipe'] as Recipe,
              comment: (settings.arguments! as Map<String, dynamic>)['comment'] as Comment,
            ));
      case kCommentsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CommentsScreen(recipe: settings.arguments as Recipe,));
      case kResetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case kProfileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case kEditProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      default:
        throw Exception(
            'Unknown route ${settings.name}. Make sure to add the route to RouteGenerator before navigating.');
    }
  }
}
