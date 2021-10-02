import 'package:flutter/material.dart';
import 'package:hing/models/hing_notification/hing_notification.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/notifications/components/notification_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final PagingController<int, HingNotification> _pagingController =
      PagingController<int, HingNotification>(firstPageKey: 1);
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();

    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    _pagingController.addPageRequestListener((pageKey) {
      userProvider.getNotifications(page: pageKey).then((notifications) {
        if (notifications.length < _perPage) {
          _pagingController.appendLastPage(notifications);
        } else {
          _pagingController.appendPage(notifications, pageKey + 1);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerScroll) => [
                    SliverAppBar(
                      title: Text('Notifications'),
                      floating: true,
                      leading: BackButton(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
              body: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                child: PagedListView.separated(
                    pagingController: _pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<HingNotification>(
                          noItemsFoundIndicatorBuilder: (_) => const EmptyIllustration(),
                            itemBuilder: (_, notification, index) =>
                                NotificationItem(notification: notification)),
                    separatorBuilder: (_, __) => Divider(
                          indent: 72.0,
                          endIndent: 16.0,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.5),
                        )),
              ))),
    );
  }
}
