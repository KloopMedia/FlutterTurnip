import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/app_bar/new_scaffold_appbar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/no_items_found_indicator.dart';

class NotificationPage extends StatefulWidget {
  final int campaignId;

  const NotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const _pageSize = 10;

  final PagingController<int, api.Notification> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _markAsRead();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final client = context.read<api.GigaTurnipApiClient>();

      final newItems = await client.getNotifications(query: {
        'limit': _pageSize,
        'offset': pageKey,
        'campaign': widget.campaignId,
      });

      final results = newItems.results;

      final isLastPage = results.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(results);
      } else {
        final nextPageKey = pageKey + results.length;
        _pagingController.appendPage(results, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _markAsRead() async {
    try {
      final client = context.read<api.GigaTurnipApiClient>();

      await client.readAllNotifications(query: {
        'campaign': widget.campaignId,
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void redirectToTaskPage() {
    context.goNamed(
      TaskRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(onPressed: redirectToTaskPage),
        title: Text(context.loc.notifications),
        titleSpacing: 0,
        leadingWidth: 64,
        toolbarHeight: 48,
      ),
      body: PagedListView<int, api.Notification>.separated(
        pagingController: _pagingController,
        reverse: true,
        padding: const EdgeInsets.all(20),
        builderDelegate: PagedChildBuilderDelegate<api.Notification>(
          itemBuilder: (context, item, index) {
            bool isFirstOfTheDay;
            try {
              final nextItem = _pagingController.itemList?[index + 1];

              isFirstOfTheDay = !DateUtils.isSameDay(item.createdAt, nextItem!.createdAt);
            } on RangeError {
              isFirstOfTheDay = true;
            } catch (e) {
              isFirstOfTheDay = false;
            }

            return NotificationListItem(
              notification: item,
              isFirstOfTheDay: isFirstOfTheDay,
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return const NoItemsFoundIndicator();
          },
        ),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}

class NotificationListItem extends StatelessWidget {
  final api.Notification notification;
  final bool isFirstOfTheDay;
  final DateTime localTime;

  NotificationListItem({super.key, required this.notification, required this.isFirstOfTheDay})
      : localTime = notification.createdAt.toLocal();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFirstOfTheDay)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                DateFormat("EEEE, d MMM y", context.loc.localeName).format(localTime),
                style: const TextStyle(
                  color: Color(0xFFAEAEAE),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Linkify(
            text: notification.text,
            style: const TextStyle(fontSize: 18),
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          DateFormat("Hm").format(localTime),
          style: const TextStyle(
            color: Color(0xFFAEAEAE),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
          ),
        )
      ],
    );
  }
}
