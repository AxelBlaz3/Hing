import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/providers/comment_provider.dart';
import 'package:hing/providers/feed_provider.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/repository/recipe_repository.dart';
import 'package:hing/repository/user_repository.dart';
import 'package:hing/routes.dart';
import 'package:hing/screens/home/home.dart';
import 'package:hing/screens/login/login.dart';
import 'package:hing/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => CommentProvider(recipeRepository: _recipeRepository)),
      ChangeNotifierProvider(
          create: (_) => FeedProvider(recipeRepository: _recipeRepository)),
      ChangeNotifierProvider(create: (_) => _authProvider),
      ChangeNotifierProvider(create: (_) => _recipeProvider)
    ],
    child: HingApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class HingApp extends StatefulWidget {
  final bool isLoggedIn;
  const HingApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  _HingAppState createState() => _HingAppState();
}

class _HingAppState extends State<HingApp> {
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
      home: widget.isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
