import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/profile/components/profile_header.dart';
import 'package:hing/screens/profile/components/profile_tab_user_content.dart';
import 'package:hing/screens/profile/components/profile_tabs.dart';
import 'package:hing/screens/profile/components/tab_posts_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              headerSliverBuilder: (context, reverse) => [
                    SliverAppBar(
                        floating: true,
                        leading: BackButton(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        title: Text(
                          S.of(context).profile,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                        actions: [
                          PopupMenuButton(
                              icon: Icon(Icons.more_vert_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              onSelected: (value) {
                                if (value == 0) {
                                  Hive.box<HingUser>(kUserBox).clear().then(
                                      (value) => Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              kLoginRoute, (route) => false));
                                }
                              },
                              itemBuilder: (_) => <PopupMenuEntry>[
                                    PopupMenuItem(
                                        value: 0,
                                        child: Text(S.of(context).logout))
                                  ])
                        ]),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ProfileHeader(),
                          ProfileTabs(),
                        ],
                      ),
                    )
                  ],
              body: TabBarView(children: [
                ProfileTabPostsContent(),
                ProfileTabUserContent(),
                ProfileTabUserContent(),
              ]))),
    );
  }
}
