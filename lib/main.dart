import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
import 'package:uni_links/uni_links.dart';

void main() async {
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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => CommentProvider(recipeRepository: _recipeRepository)),
      ChangeNotifierProvider(
          create: (_) => FeedProvider(recipeRepository: _recipeRepository)),
      ChangeNotifierProvider(create: (_) => _authProvider),
      ChangeNotifierProvider(create: (_) => _recipeProvider)
    ],
    child: HingApp(isLoggedIn: isLoggedIn, isOnBoardingDone: isOnboardingDone),
  ));
}

class HingApp extends StatefulWidget {
  final bool isLoggedIn;
  final bool isOnBoardingDone;
  const HingApp(
      {Key? key, required this.isLoggedIn, required this.isOnBoardingDone})
      : super(key: key);

  @override
  _HingAppState createState() => _HingAppState();
}

class _HingAppState extends State<HingApp> {
  Future<void> _initializeFirebase(BuildContext context) async {
    NotificationService().init();

    await Firebase.initializeApp();

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
        onGenerateRoute: RouteGenerator.onGenerateRoutes,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: FutureBuilder(
            future: _initializeFirebase(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                    child: CircularProgressIndicator(
                  color: kOnSurfaceColor,
                ));
              }

              Future.microtask(() {
                getInitialLink().then((value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('LINK - ${value}')));
                });
              });

              return widget.isLoggedIn
                  ? HomeScreen()
                  : widget.isOnBoardingDone
                      ? LoginScreen()
                      : OnboardingScreen(
                          index: 1,
                        );
            }));
  }
}
