import 'dart:async';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final RouterNotifier _authRouterNotifier;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _authRouterNotifier = RouterNotifier(authenticationRepository);

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _taskPageShellNavigatorKey = GlobalKey<NavigatorState>();
  final _notificationPageShellNavigatorKey = GlobalKey<NavigatorState>();

  String _toQueryString(Map<String, String> query, [String? removeKey]) {
    final newQuery = {...query};
    if (removeKey != null) {
      newQuery.remove(removeKey);
    }
    return Uri(queryParameters: newQuery).query;
  }

  String redirectToLoginPage(
    BuildContext context,
    GoRouterState state,
    Map<String, String> query,
  ) {
    final queryString = _toQueryString(query);
    final fromPage = state.subloc == '/' ? '' : '?from=${state.subloc}&$queryString';
    return LoginRoute.path + fromPage;
  }

  String redirectToInitialPage(
    BuildContext context,
    GoRouterState state,
    Map<String, String> query,
  ) {
    final queryString = _toQueryString(query, 'from');
    return '${state.queryParams['from'] ?? '/'}?$queryString';
  }

  Future<String?> joinCampaign(
    BuildContext context,
    GoRouterState state,
    Map<String, String> query,
    int id,
  ) async {
    await context.read<GigaTurnipApiClient>().joinCampaign(id);
    final queryString = _toQueryString(query, 'join_campaign');
    return '${TaskRelevantRoute.path.replaceFirst(':cid', '$id')}/?$queryString';
  }

  get router {
    return GoRouter(
      refreshListenable: _authRouterNotifier,
      redirect: (BuildContext context, GoRouterState state) async {
        final authenticationService = context.read<AuthenticationRepository>();

        final bool loggedIn = authenticationService.user.isNotEmpty;
        final bool loggingIn = state.subloc == LoginRoute.path;

        final query = {...state.queryParams};

        // bundle the location the user is coming from into a query parameter
        if (!loggedIn) return loggingIn ? null : redirectToLoginPage(context, state, query);

        // if the user is logged in, send them where they were going before (or
        // home if they weren't going anywhere)
        if (loggingIn) return redirectToInitialPage(context, state, query);

        // if there is query parameter <join_campaign>, then join campaign and send them to relevant task page
        final campaignIdQueryValue = query['join_campaign'];

        if (loggedIn && campaignIdQueryValue != null) {
          try {
            final campaignId = int.parse(campaignIdQueryValue);
            return await joinCampaign(context, state, query, campaignId);
          } on FormatException {
            final queryString = _toQueryString(query, 'join_campaign');
            return '${state.subloc}?$queryString';
          }
        }

        // no need to redirect at all
        return null;
      },
      navigatorKey: _rootNavigatorKey,
      routes: [
        LoginRoute(parentKey: _rootNavigatorKey).route,
        CampaignRoute(parentKey: _rootNavigatorKey).route,
        CampaignDetailRoute(parentKey: _rootNavigatorKey).route,
        TaskShellRoute(navigatorKey: _taskPageShellNavigatorKey).route,
        TaskDetailRoute(parentKey: _rootNavigatorKey).route,
        NotificationShellRoute(navigatorKey: _notificationPageShellNavigatorKey).route,
        NotificationDetailRoute(parentKey: _rootNavigatorKey).route,
      ],
    );
  }
}

class RouterNotifier extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<dynamic> _subscription;

  RouterNotifier(this._authenticationRepository) {
    notifyListeners();
    _subscription = _authenticationRepository.userStream
        .asBroadcastStream()
        .listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
