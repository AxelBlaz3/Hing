import 'package:flutter/material.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/profile/components/user_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProfileTabUserContent extends StatefulWidget {
  final bool shouldFetchFollowers;
  final HingUser user;
  const ProfileTabUserContent({Key? key, required this.shouldFetchFollowers, required this.user})
      : super(key: key);

  @override
  _ProfileTabUserContentState createState() => _ProfileTabUserContentState();
}

class _ProfileTabUserContentState extends State<ProfileTabUserContent> {
  final int _perPage = 10;
  final PagingController<int, HingUser> _pagingController =
      PagingController<int, HingUser>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    final UserProvider userProvider = Provider.of(context, listen: false);
    _pagingController.addPageRequestListener((pageKey) {
      if (widget.shouldFetchFollowers) {
        userProvider.getFollowers(page: pageKey, userId: widget.user.id.oid).then((users) {
          if (users.length < _perPage) {
            _pagingController.appendLastPage(users);
          } else {
            _pagingController.appendPage(users, pageKey + 1);
          }
        });
      } else {
        userProvider.getFollowing(page: pageKey, userId: widget.user.id.oid).then((users) {
          if (users.length < _perPage) {
            _pagingController.appendLastPage(users);
          } else {
            _pagingController.appendPage(users, pageKey + 1);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {},
        child: PagedListView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<HingUser>(
                itemBuilder: (_, user, index) => UserItem(
                    user: user,
                    isFollowing: widget.shouldFetchFollowers,
                    refreshCallback: (updatedUser) {
                      final List<HingUser> updatedUsers =
                          _pagingController.itemList as List<HingUser>
                            ..[index] = updatedUser;
                      _pagingController.itemList = updatedUsers;
                    }))));
  }
}
