import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hing/notification_service.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/providers/comment_provider.dart';
import 'package:hing/providers/feed_provider.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/repository/recipe_repository.dart';
import 'package:hing/repository/user_repository.dart';
import 'package:hing/routes.dart';
import 'package:hing/screens/home/home.dart';
import 'package:hing/screens/login/login.dart';
import 'package:hing/screens/onboarding/onboarding.dart';
import 'package:hing/theme/colors.dart';
import 'package:hing/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'enums/notification_type.dart';
import 'providers/ingredients_provider.dart';

//latest 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final UserRepository _userRepository = UserRepository();
  final RecipeRepository _recipeRepository = RecipeRepository();
  final UserProvider _authProvider =
      UserProvider(userRepository: _userRepository);
  final RecipeProvider _recipeProvider =
      RecipeProvider(recipeRepository: _recipeRepository);

  await Hive.initFlutter();

  Hive.registerAdapter(ObjectIdAdapter());
  Hive.registerAdapter(HingUserAdapter());

  await Hive.openBox<HingUser>(kUserBox);

  final bool isLoggedIn =
      Hive.box<HingUser>(kUserBox).get(kUserKey, defaultValue: null) != null;
  final bool isOnboardingDone =
      (await SharedPreferences.getInstance()).getBool(kOnBoardingPrefKey) ??
          false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                CommentProvider(recipeRepository: _recipeRepository)),
        ChangeNotifierProvider(
            create: (_) => FeedProvider(recipeRepository: _recipeRepository)),
        ChangeNotifierProvider(create: (_) => _authProvider),
        ChangeNotifierProvider(create: (_) => _recipeProvider),
        ChangeNotifierProvider(create: (_) => IngredientsProvider()),
      ],
      child:
          HingApp(isLoggedIn: isLoggedIn, isOnBoardingDone: isOnboardingDone),
    ),
  );

  FirebaseMessaging.onBackgroundMessage(backgroundPushNotificationHandler);
}

class HingApp extends StatefulWidget {
  final bool isLoggedIn;
  final bool isOnBoardingDone;
  const HingApp({
    Key? key,
    required this.isLoggedIn,
    required this.isOnBoardingDone,
  }) : super(key: key);

  @override
  _HingAppState createState() => _HingAppState();
}

class _HingAppState extends State<HingApp> {
  Future<void> _initializeFirebase(BuildContext context) async {
    initDynamicLinks(context);
    NotificationService().init();

    await Firebase.initializeApp();

    FirebaseMessaging.onMessage.listen(pushNotificationHandler);

    final String? firebaseToken = await FirebaseMessaging.instance.getToken();

    HingUser? user = Hive.box<HingUser>(kUserBox).get(kUserKey);
    if (firebaseToken != null) {
      if (user?.firebaseToken != firebaseToken) {
        if (user != null) {
          await Hive.box<HingUser>(kUserBox)
              .put(kUserKey, user..firebaseToken = firebaseToken);

          context
              .read<UserProvider>()
              .updateFirebaseToken(firebaseToken: firebaseToken);
        }
      }
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      HingUser? user = Hive.box<HingUser>(kUserBox).get(kUserKey);
      if (user != null) {
        await Hive.box<HingUser>(kUserBox)
            .put(kUserKey, user..firebaseToken = token);

        context.read<UserProvider>().updateFirebaseToken(firebaseToken: token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: HingTheme.getHingThemeData(ThemeData.light()),
        darkTheme: HingTheme.getHingDarkThemeData(ThemeData.dark()),
        onGenerateRoute: RouteGenerator.onGenerateRoutes,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
            builder: (context) => FutureBuilder(
                future: _initializeFirebase(context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: kOnSurfaceColor,
                    ));
                  }

                  return widget.isLoggedIn
                      ? HomeScreen()
                      : widget.isOnBoardingDone
                          ? LoginScreen()
                          : OnboardingScreen(
                              index: 1,
                            );
                })));
  }

  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        if (deepLink.path == '/recipe') {
          Navigator.of(context).pushNamed(kDetailsRoute,
              arguments: deepLink.queryParameters['recipe_id']);
          // Navigator.pushNamed(context, kDetailsRoute,
          //     arguments: deepLink.queryParameters['id']);
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.of(context).pushNamed(kDetailsRoute,
          arguments: deepLink.queryParameters['recipe_id']);
    }
  }

  void pushNotificationHandler(RemoteMessage message) {
    final payload = message.data;
    final int notificationType = int.parse(payload['type']);
    String? body;
    String? title;

    if (notificationType == NotificationType.likePost.index) {
      title = '${payload["recipe"]}';
      body = '${payload["display_name"]} liked your recipe.';
    } else if (notificationType == NotificationType.likeComment.index) {
      title = '${payload["display_name"]} liked your comment.';
      body = '${payload["comment"]}';
    } else if (notificationType == NotificationType.likeReply.index) {
      title = '${payload["display_name"]} liked your reply.';
      body = '${payload["reply"]}';
    } else if (notificationType == NotificationType.newFollower.index) {
      body = '${payload["display_name"]} started following you.';
    } else if (notificationType == NotificationType.newComment.index) {
      title = '${payload["display_name"]} commented';
      body = '${payload["comment"]}';
    } else if (notificationType == NotificationType.newReply.index) {
      title = '${payload["display_name"]} replied';
      body = '${payload["comment"]}';
    }

    if (body != null) {
      Provider.of<UserProvider>(context, listen: false)
          .setShowNotificationBadge(true);
      NotificationService().showNotifications(title, body, payload);
    }
  }
}
