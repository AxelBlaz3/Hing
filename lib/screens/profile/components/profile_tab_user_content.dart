import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/profile/components/user_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileTabUserContent extends StatefulWidget {
  final bool shouldFetchFollowers;
  final HingUser user;
  final PagingController<int, HingUser> pagingController;
  final Function(HingUser) refreshCallback;

  const ProfileTabUserContent(
      {Key? key,
      required this.shouldFetchFollowers,
      required this.user,
      required this.pagingController,
      required this.refreshCallback})
      : super(key: key);

  @override
  _ProfileTabUserContentState createState() => _ProfileTabUserContentState();
}

class _ProfileTabUserContentState extends State<ProfileTabUserContent> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => widget.pagingController.refresh()),
      child: PagedListView(
        pagingController: widget.pagingController,
        builderDelegate: PagedChildBuilderDelegate<HingUser>(
          noItemsFoundIndicatorBuilder: (_) => EmptyIllustration(
            assetPath: 'assets/no_users_illustration.png',
            title: S.of(context).noRecipesTitle,
            summary: S.of(context).noUsersSummary,
          ),
          itemBuilder: (_, user, index) => UserItem(
            user: user,
            isFollowing: widget.shouldFetchFollowers,
            refreshCallback: (updatedUser) {
              final List<HingUser> updatedUsers =
                  widget.pagingController.itemList as List<HingUser>
                    ..[index] = updatedUser;
              widget.pagingController.itemList = List.of(updatedUsers);

              // Call refreshCallback on widget to update other list.
              widget.refreshCallback(updatedUser);
            },
          ),
        ),
      ),
    );
  }
}
