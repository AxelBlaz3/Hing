// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hing`
  String get hing {
    return Intl.message(
      'Hing',
      name: 'hing',
      desc: '',
      args: [],
    );
  }

  /// `{likesCount, plural, one{1 like} other{{likesCount} likes}}`
  String xLikes(num likesCount) {
    return Intl.plural(
      likesCount,
      one: '1 like',
      other: '$likesCount likes',
      name: 'xLikes',
      desc: '',
      args: [likesCount],
    );
  }

  /// `{commentsCount, plural, one{1 comment} other{{commentsCount} comments}}`
  String xComments(num commentsCount) {
    return Intl.plural(
      commentsCount,
      one: '1 comment',
      other: '$commentsCount comments',
      name: 'xComments',
      desc: '',
      args: [commentsCount],
    );
  }

  /// `{repliesCount, plural, one{1 reply} other{{repliesCount} replies}}`
  String xReplies(num repliesCount) {
    return Intl.plural(
      repliesCount,
      one: '1 reply',
      other: '$repliesCount replies',
      name: 'xReplies',
      desc: '',
      args: [repliesCount],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message(
      'Unfollow',
      name: 'unfollow',
      desc: '',
      args: [],
    );
  }

  /// `Add to Favorite`
  String get addToFavorite {
    return Intl.message(
      'Add to Favorite',
      name: 'addToFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Create a Recipe`
  String get createARecipe {
    return Intl.message(
      'Create a Recipe',
      name: 'createARecipe',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD A PHOTO`
  String get uploadAPhoto {
    return Intl.message(
      'UPLOAD A PHOTO',
      name: 'uploadAPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Supported formats PNG or JPG or MP4. Photos are usually 400x300 or 800x600 but not enforced.`
  String get uploadPhotoDesc {
    return Intl.message(
      'Supported formats PNG or JPG or MP4. Photos are usually 400x300 or 800x600 but not enforced.',
      name: 'uploadPhotoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addItem {
    return Intl.message(
      'Add Item',
      name: 'addItem',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get posts {
    return Intl.message(
      'Posts',
      name: 'posts',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Replies`
  String get replies {
    return Intl.message(
      'Replies',
      name: 'replies',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginToYourAccount {
    return Intl.message(
      'Login to your account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Congrats`
  String get congrats {
    return Intl.message(
      'Congrats',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get passwordResetSuccessful {
    return Intl.message(
      'Password reset successful',
      name: 'passwordResetSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset your password`
  String get resetYourPassword {
    return Intl.message(
      'Reset your password',
      name: 'resetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login`
  String get alreadyhaveAnAccount {
    return Intl.message(
      'Already have an account? Login',
      name: 'alreadyhaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAnAccount {
    return Intl.message(
      'Create an account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get displayName {
    return Intl.message(
      'Display name',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password and repeat it once more to get your password changed.`
  String get resetPasswordHint {
    return Intl.message(
      'Enter your new password and repeat it once more to get your password changed.',
      name: 'resetPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Email cannot be empty.`
  String get emailCannotBeEmpty {
    return Intl.message(
      'Email cannot be empty.',
      name: 'emailCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty.`
  String get nameCannotBeEmpty {
    return Intl.message(
      'Name cannot be empty.',
      name: 'nameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be empty.`
  String get passwordCannotBeEmpty {
    return Intl.message(
      'Password cannot be empty.',
      name: 'passwordCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Min. 8 chars.`
  String get passwordMustBeAtLeast8Chars {
    return Intl.message(
      'Min. 8 chars.',
      name: 'passwordMustBeAtLeast8Chars',
      desc: '',
      args: [],
    );
  }

  /// `That email is not available.`
  String get emailNotAvailable {
    return Intl.message(
      'That email is not available.',
      name: 'emailNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect credentials.`
  String get incorrectCredentials {
    return Intl.message(
      'Incorrect credentials.',
      name: 'incorrectCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `PREVIEW`
  String get preview {
    return Intl.message(
      'PREVIEW',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get all {
    return Intl.message(
      'ALL',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `INDIAN`
  String get indian {
    return Intl.message(
      'INDIAN',
      name: 'indian',
      desc: '',
      args: [],
    );
  }

  /// `CHINESE`
  String get chinese {
    return Intl.message(
      'CHINESE',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `ITALIAN`
  String get italian {
    return Intl.message(
      'ITALIAN',
      name: 'italian',
      desc: '',
      args: [],
    );
  }

  /// `MEXICAN`
  String get mexican {
    return Intl.message(
      'MEXICAN',
      name: 'mexican',
      desc: '',
      args: [],
    );
  }

  /// `CONTINENTAL`
  String get continental {
    return Intl.message(
      'CONTINENTAL',
      name: 'continental',
      desc: '',
      args: [],
    );
  }

  /// `OTHERS`
  String get others {
    return Intl.message(
      'OTHERS',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `1`
  String get quantity_hint {
    return Intl.message(
      '1',
      name: 'quantity_hint',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `New Ingredient`
  String get newIngredient {
    return Intl.message(
      'New Ingredient',
      name: 'newIngredient',
      desc: '',
      args: [],
    );
  }

  /// `You can add more ingredients by clicking the ADD MORE button`
  String get newIngredientSummary {
    return Intl.message(
      'You can add more ingredients by clicking the ADD MORE button',
      name: 'newIngredientSummary',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients cannot be empty`
  String get ingredientsCannotBeEmpty {
    return Intl.message(
      'Ingredients cannot be empty',
      name: 'ingredientsCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `ADD MORE`
  String get addMore {
    return Intl.message(
      'ADD MORE',
      name: 'addMore',
      desc: '',
      args: [],
    );
  }

  /// `DONE`
  String get done {
    return Intl.message(
      'DONE',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient name cannot be empty`
  String get ingredientCannotBeEmptyError {
    return Intl.message(
      'Ingredient name cannot be empty',
      name: 'ingredientCannotBeEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Quantity cannot be empty`
  String get quantityCannotBeEmptyError {
    return Intl.message(
      'Quantity cannot be empty',
      name: 'quantityCannotBeEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `New recipe created.`
  String get newRecipeCreated {
    return Intl.message(
      'New recipe created.',
      name: 'newRecipeCreated',
      desc: '',
      args: [],
    );
  }

  /// `Type your comment here`
  String get typeYourCommentHere {
    return Intl.message(
      'Type your comment here',
      name: 'typeYourCommentHere',
      desc: '',
      args: [],
    );
  }

  /// `Type your reply here`
  String get typeYourReplyHere {
    return Intl.message(
      'Type your reply here',
      name: 'typeYourReplyHere',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get reply {
    return Intl.message(
      'Reply',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Remove from favorites`
  String get removeFromFavorites {
    return Intl.message(
      'Remove from favorites',
      name: 'removeFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message(
      'You',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `{follower} started following you.`
  String xFollowedY(Object follower) {
    return Intl.message(
      '$follower started following you.',
      name: 'xFollowedY',
      desc: '',
      args: [follower],
    );
  }

  /// `{user} liked your recipe.`
  String xLikedYPost(Object user) {
    return Intl.message(
      '$user liked your recipe.',
      name: 'xLikedYPost',
      desc: '',
      args: [user],
    );
  }

  /// `{user} liked your comment`
  String xLikedYComment(Object user) {
    return Intl.message(
      '$user liked your comment',
      name: 'xLikedYComment',
      desc: '',
      args: [user],
    );
  }

  /// `{user} liked your reply`
  String xLikeYReply(Object user) {
    return Intl.message(
      '$user liked your reply',
      name: 'xLikeYReply',
      desc: '',
      args: [user],
    );
  }

  /// `{user} commented on your recipe`
  String xCommentedOnYourRecipe(Object user) {
    return Intl.message(
      '$user commented on your recipe',
      name: 'xCommentedOnYourRecipe',
      desc: '',
      args: [user],
    );
  }

  /// `{user} replied to your comment`
  String xRepliedToYourComment(Object user) {
    return Intl.message(
      '$user replied to your comment',
      name: 'xRepliedToYourComment',
      desc: '',
      args: [user],
    );
  }

  /// `Profile updated`
  String get profileUpdated {
    return Intl.message(
      'Profile updated',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Fix errors and submit`
  String get fixErrorsAbove {
    return Intl.message(
      'Fix errors and submit',
      name: 'fixErrorsAbove',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get noRecipesTitle {
    return Intl.message(
      'Oops!',
      name: 'noRecipesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No recipes found here. Be the first to post under this category.`
  String get noRecipesFound {
    return Intl.message(
      'No recipes found here. Be the first to post under this category.',
      name: 'noRecipesFound',
      desc: '',
      args: [],
    );
  }

  /// `Users following you will appear here.`
  String get noFollowersSummary {
    return Intl.message(
      'Users following you will appear here.',
      name: 'noFollowersSummary',
      desc: '',
      args: [],
    );
  }

  /// `Users being followed by you appear here.`
  String get noFollowingSummary {
    return Intl.message(
      'Users being followed by you appear here.',
      name: 'noFollowingSummary',
      desc: '',
      args: [],
    );
  }

  /// `No followers yet.`
  String get noOtherUserFollowersSummary {
    return Intl.message(
      'No followers yet.',
      name: 'noOtherUserFollowersSummary',
      desc: '',
      args: [],
    );
  }

  /// `No following yet.`
  String get noOtherUserFollowingSummary {
    return Intl.message(
      'No following yet.',
      name: 'noOtherUserFollowingSummary',
      desc: '',
      args: [],
    );
  }

  /// `No posts yet`
  String get noPostsTitle {
    return Intl.message(
      'No posts yet',
      name: 'noPostsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recipes published by you will appear here.`
  String get noPostsSummary {
    return Intl.message(
      'Recipes published by you will appear here.',
      name: 'noPostsSummary',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet. Any updates will appear here.`
  String get noNotificationsSummary {
    return Intl.message(
      'No notifications yet. Any updates will appear here.',
      name: 'noNotificationsSummary',
      desc: '',
      args: [],
    );
  }

  /// `No comments yet`
  String get noCommentsTitle {
    return Intl.message(
      'No comments yet',
      name: 'noCommentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No replies yet`
  String get noRepliesTitle {
    return Intl.message(
      'No replies yet',
      name: 'noRepliesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Let others know how tasty this recipe is.`
  String get noCommentsSummary {
    return Intl.message(
      'Let others know how tasty this recipe is.',
      name: 'noCommentsSummary',
      desc: '',
      args: [],
    );
  }

  /// `Let others know how tasty this recipe is.`
  String get noRepliesSummary {
    return Intl.message(
      'Let others know how tasty this recipe is.',
      name: 'noRepliesSummary',
      desc: '',
      args: [],
    );
  }

  /// `No one here. Come back later`
  String get noUsersSummary {
    return Intl.message(
      'No one here. Come back later',
      name: 'noUsersSummary',
      desc: '',
      args: [],
    );
  }

  /// `Hang on`
  String get hangOn {
    return Intl.message(
      'Hang on',
      name: 'hangOn',
      desc: '',
      args: [],
    );
  }

  /// `Your recipe is being published.`
  String get publishingSummary {
    return Intl.message(
      'Your recipe is being published.',
      name: 'publishingSummary',
      desc: '',
      args: [],
    );
  }

  /// `Create your password`
  String get createNewPassword {
    return Intl.message(
      'Create your password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email associated with your account and We'll send an email with instructions to reset your password.`
  String get resetNewPasswordSummary {
    return Intl.message(
      'Enter the email associated with your account and We\'ll send an email with instructions to reset your password.',
      name: 'resetNewPasswordSummary',
      desc: '',
      args: [],
    );
  }

  /// `Send Instructions`
  String get sendInstructions {
    return Intl.message(
      'Send Instructions',
      name: 'sendInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must match.`
  String get passwordsMustMatch {
    return Intl.message(
      'Passwords must match.',
      name: 'passwordsMustMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password should container at least 8 characters.`
  String get passwordShouldContainAtleastEightChars {
    return Intl.message(
      'Password should container at least 8 characters.',
      name: 'passwordShouldContainAtleastEightChars',
      desc: '',
      args: [],
    );
  }

  /// `Code cannot be empty.`
  String get codeIsEmpty {
    return Intl.message(
      'Code cannot be empty.',
      name: 'codeIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Find your comfort food here`
  String get onboardingOneTitle {
    return Intl.message(
      'Find your comfort food here',
      name: 'onboardingOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Here you can find a chef or dish for every taste and color. Enjoy!`
  String get onboardingOneSummary {
    return Intl.message(
      'Here you can find a chef or dish for every taste and color. Enjoy!',
      name: 'onboardingOneSummary',
      desc: '',
      args: [],
    );
  }

  /// `Food Ninja is where your comfort food lives`
  String get onboardingTwoTitle {
    return Intl.message(
      'Food Ninja is where your comfort food lives',
      name: 'onboardingTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy a fast and smooth food delivery at your doorstep.`
  String get onboardingTwoSummary {
    return Intl.message(
      'Enjoy a fast and smooth food delivery at your doorstep.',
      name: 'onboardingTwoSummary',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email.`
  String get enterAValidEmail {
    return Intl.message(
      'Enter a valid email.',
      name: 'enterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password updated`
  String get passwordUpdated {
    return Intl.message(
      'Password updated',
      name: 'passwordUpdated',
      desc: '',
      args: [],
    );
  }

  /// `LOADING`
  String get loading {
    return Intl.message(
      'LOADING',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `That account doesn't exist.`
  String get thatAccountDoesntExists {
    return Intl.message(
      'That account doesn\'t exist.',
      name: 'thatAccountDoesntExists',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD PHOTO`
  String get uploadPhoto {
    return Intl.message(
      'UPLOAD PHOTO',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
