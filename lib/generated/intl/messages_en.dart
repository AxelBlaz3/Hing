// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(user) => "${user} commented on your recipe";

  static String m1(commentsCount) =>
      "${Intl.plural(commentsCount, one: '1 comment', other: '${commentsCount} comments')}";

  static String m2(follower) => "${follower} started following you.";

  static String m3(user) => "${user} liked your reply";

  static String m4(user) => "${user} liked your comment";

  static String m5(user) => "${user} liked your recipe.";

  static String m6(likesCount) =>
      "${Intl.plural(likesCount, one: '1 like', other: '${likesCount} likes')}";

  static String m7(repliesCount) =>
      "${Intl.plural(repliesCount, one: '1 reply', other: '${repliesCount} replies')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addItem": MessageLookupByLibrary.simpleMessage("Add Item"),
        "addMore": MessageLookupByLibrary.simpleMessage("ADD MORE"),
        "addToFavorite":
            MessageLookupByLibrary.simpleMessage("Add to Favorite"),
        "all": MessageLookupByLibrary.simpleMessage("ALL"),
        "alreadyhaveAnAccount": MessageLookupByLibrary.simpleMessage(
            "Already have an account? Login"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "chinese": MessageLookupByLibrary.simpleMessage("CHINESE"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "codeIsEmpty":
            MessageLookupByLibrary.simpleMessage("Code cannot be empty."),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "comments": MessageLookupByLibrary.simpleMessage("Comments"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "congrats": MessageLookupByLibrary.simpleMessage("Congrats"),
        "continental": MessageLookupByLibrary.simpleMessage("CONTINENTAL"),
        "createARecipe":
            MessageLookupByLibrary.simpleMessage("Create a Recipe"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "createAnAccount":
            MessageLookupByLibrary.simpleMessage("Create an account"),
        "createNewPassword":
            MessageLookupByLibrary.simpleMessage("Create your password"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "displayName": MessageLookupByLibrary.simpleMessage("Display name"),
        "done": MessageLookupByLibrary.simpleMessage("DONE"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Email cannot be empty."),
        "emailNotAvailable": MessageLookupByLibrary.simpleMessage(
            "That email is not available."),
        "emptyTitle": MessageLookupByLibrary.simpleMessage("Oops!"),
        "enterAValidEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email."),
        "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
        "fixErrorsAbove":
            MessageLookupByLibrary.simpleMessage("Fix errors and submit"),
        "follow": MessageLookupByLibrary.simpleMessage("Follow"),
        "followers": MessageLookupByLibrary.simpleMessage("Followers"),
        "following": MessageLookupByLibrary.simpleMessage("Following"),
        "forgotYourPassword":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "hangOn": MessageLookupByLibrary.simpleMessage("Hang on"),
        "hing": MessageLookupByLibrary.simpleMessage("Hing"),
        "image": MessageLookupByLibrary.simpleMessage("Image"),
        "incorrectCredentials":
            MessageLookupByLibrary.simpleMessage("Incorrect credentials."),
        "indian": MessageLookupByLibrary.simpleMessage("INDIAN"),
        "ingredientCannotBeEmptyError": MessageLookupByLibrary.simpleMessage(
            "Ingredient name cannot be empty"),
        "ingredients": MessageLookupByLibrary.simpleMessage("Ingredients"),
        "italian": MessageLookupByLibrary.simpleMessage("ITALIAN"),
        "item": MessageLookupByLibrary.simpleMessage("Item"),
        "like": MessageLookupByLibrary.simpleMessage("Like"),
        "loading": MessageLookupByLibrary.simpleMessage("LOADING"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginToYourAccount":
            MessageLookupByLibrary.simpleMessage("Login to your account"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "mexican": MessageLookupByLibrary.simpleMessage("MEXICAN"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "newIngredient": MessageLookupByLibrary.simpleMessage("New Ingredient"),
        "newIngredientSummary": MessageLookupByLibrary.simpleMessage(
            "You can add more ingredients by clicking the ADD MORE button"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "newRecipeCreated":
            MessageLookupByLibrary.simpleMessage("New recipe created."),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noRecipesFound": MessageLookupByLibrary.simpleMessage(
            "No recipes found here. Be the first to post under this category."),
        "onboardingOneSummary": MessageLookupByLibrary.simpleMessage(
            "Here you can find a chef or dish for every taste and color. Enjoy!"),
        "onboardingOneTitle":
            MessageLookupByLibrary.simpleMessage("Find your comfort food here"),
        "onboardingTwoSummary": MessageLookupByLibrary.simpleMessage(
            "Enjoy a fast and smooth food delivery at your doorstep."),
        "onboardingTwoTitle": MessageLookupByLibrary.simpleMessage(
            "Food Ninja is where your comfort food lives"),
        "others": MessageLookupByLibrary.simpleMessage("OTHERS"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Password cannot be empty."),
        "passwordMustBeAtLeast8Chars":
            MessageLookupByLibrary.simpleMessage("Min. 8 chars."),
        "passwordResetSuccessful":
            MessageLookupByLibrary.simpleMessage("Password reset successful"),
        "passwordShouldContainAtleastEightChars":
            MessageLookupByLibrary.simpleMessage(
                "Password should container at least 8 characters."),
        "passwordUpdated":
            MessageLookupByLibrary.simpleMessage("Password updated"),
        "passwordsMustMatch":
            MessageLookupByLibrary.simpleMessage("Passwords must match."),
        "posts": MessageLookupByLibrary.simpleMessage("Posts"),
        "preview": MessageLookupByLibrary.simpleMessage("PREVIEW"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profile updated"),
        "publish": MessageLookupByLibrary.simpleMessage("Publish"),
        "publishingSummary": MessageLookupByLibrary.simpleMessage(
            "Your recipe is being published."),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "quantityCannotBeEmptyError":
            MessageLookupByLibrary.simpleMessage("Quantity cannot be empty"),
        "quantity_hint": MessageLookupByLibrary.simpleMessage("1"),
        "removeFromFavorites":
            MessageLookupByLibrary.simpleMessage("Remove from favorites"),
        "replies": MessageLookupByLibrary.simpleMessage("Replies"),
        "reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "resetNewPasswordSummary": MessageLookupByLibrary.simpleMessage(
            "Enter the email associated with your account and We\'ll send an email with instructions to reset your password."),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordHint": MessageLookupByLibrary.simpleMessage(
            "Enter your new password and repeat it once more to get your password changed."),
        "resetYourPassword":
            MessageLookupByLibrary.simpleMessage("Reset your password"),
        "sendInstructions":
            MessageLookupByLibrary.simpleMessage("Send Instructions"),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong."),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "thatAccountDoesntExists": MessageLookupByLibrary.simpleMessage(
            "That account doesn\'t exist."),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "typeYourCommentHere":
            MessageLookupByLibrary.simpleMessage("Type your comment here"),
        "typeYourReplyHere":
            MessageLookupByLibrary.simpleMessage("Type your reply here"),
        "unfollow": MessageLookupByLibrary.simpleMessage("Unfollow"),
        "units": MessageLookupByLibrary.simpleMessage("Units"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "uploadAPhoto": MessageLookupByLibrary.simpleMessage("UPLOAD A PHOTO"),
        "uploadPhotoDesc": MessageLookupByLibrary.simpleMessage(
            "Supported formats PNG or JPG or MP4. Photos are usually 400x300 or 800x600 but not enforced."),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "xCommentedOnYourRecipe": m0,
        "xComments": m1,
        "xFollowedY": m2,
        "xLikeYReply": m3,
        "xLikedYComment": m4,
        "xLikedYPost": m5,
        "xLikes": m6,
        "xReplies": m7,
        "you": MessageLookupByLibrary.simpleMessage("You")
      };
}
