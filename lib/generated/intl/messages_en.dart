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

  static String m2(howMany) => "${howMany} comments";

  static String m3(follower) => "${follower} started following you.";

  static String m4(user) => "${user} liked your reply";

  static String m5(user) => "${user} liked your comment";

  static String m6(user) => "${user} liked your recipe";

  static String m7(likesCount) =>
      "${Intl.plural(likesCount, one: '1 like', other: '${likesCount} likes')}";

  static String m8(howMany) => "${howMany} likes";

  static String m9(user) => "${user} replied to your comment";

  static String m10(repliesCount) =>
      "${Intl.plural(repliesCount, one: '1 reply', other: '${repliesCount} replies')}";

  static String m11(howMany) => "${howMany} replies";

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
        "checkYourConnection": MessageLookupByLibrary.simpleMessage(
            "Check your connection and try again."),
        "chinese": MessageLookupByLibrary.simpleMessage("CHINESE"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "codeIsEmpty":
            MessageLookupByLibrary.simpleMessage("Code cannot be empty."),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "commentedOnYourRecipe":
            MessageLookupByLibrary.simpleMessage(" commented on your recipe "),
        "comments": MessageLookupByLibrary.simpleMessage("Comments"),
        "commentsLabel": MessageLookupByLibrary.simpleMessage("comments"),
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
        "ingredientsCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Ingredients cannot be empty"),
        "italian": MessageLookupByLibrary.simpleMessage("ITALIAN"),
        "item": MessageLookupByLibrary.simpleMessage("Item"),
        "like": MessageLookupByLibrary.simpleMessage("Like"),
        "likedYourComment":
            MessageLookupByLibrary.simpleMessage(" liked your comment "),
        "likedYourRecipe":
            MessageLookupByLibrary.simpleMessage(" liked your recipe "),
        "likedYourReply":
            MessageLookupByLibrary.simpleMessage(" liked your reply "),
        "likes": MessageLookupByLibrary.simpleMessage("Likes"),
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
        "noCommentsSummary": MessageLookupByLibrary.simpleMessage(
            "Let others know how tasty this recipe is."),
        "noCommentsTitle":
            MessageLookupByLibrary.simpleMessage("No comments yet"),
        "noFollowersSummary": MessageLookupByLibrary.simpleMessage(
            "Users following you will appear here."),
        "noFollowingSummary": MessageLookupByLibrary.simpleMessage(
            "Users being followed by you appear here."),
        "noNotificationsSummary": MessageLookupByLibrary.simpleMessage(
            "No notifications yet. Any updates will appear here."),
        "noOtherUserFollowersSummary":
            MessageLookupByLibrary.simpleMessage("No followers yet."),
        "noOtherUserFollowingSummary":
            MessageLookupByLibrary.simpleMessage("No following yet."),
        "noPostsSummary": MessageLookupByLibrary.simpleMessage(
            "Recipes published by you will appear here."),
        "noPostsTitle": MessageLookupByLibrary.simpleMessage("No posts yet"),
        "noRecipesFound": MessageLookupByLibrary.simpleMessage(
            "No recipes found here. Be the first to post under this category."),
        "noRecipesTitle": MessageLookupByLibrary.simpleMessage("Oops!"),
        "noRepliesSummary": MessageLookupByLibrary.simpleMessage(
            "Let others know how tasty this recipe is."),
        "noRepliesTitle":
            MessageLookupByLibrary.simpleMessage("No replies yet"),
        "noUsersSummary": MessageLookupByLibrary.simpleMessage(
            "No one here. Come back later"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
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
        "repliedToYourComment":
            MessageLookupByLibrary.simpleMessage(" replied to your comment "),
        "replies": MessageLookupByLibrary.simpleMessage("Replies"),
        "repliesLabel": MessageLookupByLibrary.simpleMessage("replies"),
        "reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "resetNewPasswordSummary": MessageLookupByLibrary.simpleMessage(
            "Enter the email associated with your account and We\'ll send an email with instructions to reset your password."),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordHint": MessageLookupByLibrary.simpleMessage(
            "Enter your new password and repeat it once more to get your password changed."),
        "resetYourPassword":
            MessageLookupByLibrary.simpleMessage("Reset your password"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "sendInstructions":
            MessageLookupByLibrary.simpleMessage("Send Instructions"),
        "serverIsUnavailable": MessageLookupByLibrary.simpleMessage(
            "Server is down, try again later."),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong."),
        "startedFollowingYou":
            MessageLookupByLibrary.simpleMessage(" started following you."),
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
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("UPLOAD PHOTO"),
        "uploadPhotoDesc": MessageLookupByLibrary.simpleMessage(
            "Supported formats PNG or JPG or MP4. Photos are usually 400x300 or 800x600 but not enforced."),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "xCommentedOnYourRecipe": m0,
        "xComments": m1,
        "xCommentsLabel": m2,
        "xFollowedY": m3,
        "xLikeYReply": m4,
        "xLikedYComment": m5,
        "xLikedYPost": m6,
        "xLikes": m7,
        "xLikesLabel": m8,
        "xRepliedToYourComment": m9,
        "xReplies": m10,
        "xRepliesLabel": m11,
        "you": MessageLookupByLibrary.simpleMessage("You")
      };
}
