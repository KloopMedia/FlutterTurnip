import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';

import 'utilities.dart';

class AppRouter {
  final RouterNotifier _authRouterNotifier;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _authRouterNotifier = RouterNotifier(authenticationRepository);

  final _initialLocation = CampaignRoute.path;
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  String redirectToLoginPage(BuildContext context, GoRouterState state) {
    final query = {...state.uri.queryParameters};

    final queryString = toQueryString(query);
    final fromPage = state.matchedLocation == _initialLocation
        ? ''
        : '?from=${state.matchedLocation}&$queryString';
    return LoginRoute.path + fromPage;
  }

  String redirectToInitialPage(BuildContext context, GoRouterState state) {
    final query = {...state.uri.queryParameters};

    final queryString = toQueryString(query, 'from');
    return '${state.uri.queryParameters['from'] ?? _initialLocation}?$queryString';
  }

  String redirectToNotificationDetailPage(BuildContext context, GoRouterState state) {
    final query = {...state.uri.queryParameters};
    final queryString = toQueryString(query, 'from');
    final fromPage = state.matchedLocation == NotificationDetailRoute.path
        ? ''
        : '?from=${state.matchedLocation}&$queryString';
    return NotificationDetailRoute.path + fromPage;
  }

  String redirectToPrivacyPolicyPage(BuildContext context, GoRouterState state) {
    final query = {...state.uri.queryParameters};
    final queryString = toQueryString(query, 'from');
    final fromPage = state.matchedLocation == PrivacyPolicyRoute.path
        ? ''
        : '?from=${state.matchedLocation}&$queryString';
    return PrivacyPolicyRoute.path + fromPage;
  }

  Future<String?> joinCampaign(BuildContext context, GoRouterState state) async {
    final query = {...state.uri.queryParameters};
    final queryString = toQueryString(query, 'join_campaign');

    try {
      final campaignId = int.parse(query['join_campaign']!);
      await context.read<GigaTurnipApiClient>().joinCampaign(campaignId);
      return '${TaskRoute.path.replaceFirst(':cid', '$campaignId')}/?$queryString';
    } on FormatException {
      return '${state.matchedLocation}?$queryString';
    }
  }

  get router {
    return GoRouter(
      initialLocation: _initialLocation,
      refreshListenable: _authRouterNotifier,
      onException: (_, GoRouterState state, GoRouter router) {
        final location = state.uri.toString() + (state.uri.toString().endsWith('/') ? '' : '/');
        if (location.contains('#')) {
          final routes = location.split('#');
          final prefix = routes.first;

          if (prefix == '/FlutterTurnip/') {
            router.go(routes.last);
          }
        } else {
          router.goNamed(CampaignRoute.name, pathParameters: state.pathParameters);
        }
      },
      redirect: (BuildContext context, GoRouterState state) async {
        final authenticationService = context.read<AuthenticationRepository>();
        final query = {...state.uri.queryParameters};
        final bool loggedIn = authenticationService.user.isNotEmpty;
        final bool isPrivacyPolicyRoute = state.matchedLocation == PrivacyPolicyRoute.path;
        final bool loggingIn = state.matchedLocation == LoginRoute.path;
        final bool gettingPushNotification = state.matchedLocation == NotificationDetailRoute.path;
        final campaignIdQueryValue = query['join_campaign'];

        if (isPrivacyPolicyRoute) return redirectToPrivacyPolicyPage(context, state);

        // bundle the location the user is coming from into a query parameter
        if (!loggedIn) return loggingIn ? null : redirectToLoginPage(context, state);

        // if there is push notification, then send user to NotificationDetailPage
        if (gettingPushNotification) return redirectToNotificationDetailPage(context, state);


        // if the user is logged in, send them where they were going before (or
        // home if they weren't going anywhere)
        if (loggingIn) return redirectToInitialPage(context, state);

        // if there is query parameter <join_campaign>, then join campaign and send them to relevant task page
        if (loggedIn && campaignIdQueryValue != null) {
          return await joinCampaign(context, state);
        }

        // no need to redirect at all
        return null;
      },
      navigatorKey: _rootNavigatorKey,
      routes: [
        LoginRoute(parentKey: _rootNavigatorKey).route,
        CampaignRoute(parentKey: _rootNavigatorKey).route,
        CampaignDetailRoute(parentKey: _rootNavigatorKey).route,
        TaskRoute(parentKey: _rootNavigatorKey).route,
        AvailableTaskRoute(parentKey: _rootNavigatorKey).route,
        TaskDetailRoute(parentKey: _rootNavigatorKey).route,
        NotificationRoute(parentKey: _rootNavigatorKey).route,
        NotificationDetailRoute(parentKey: _rootNavigatorKey).route,
        SettingsRoute(parentKey: _rootNavigatorKey).route,
        ChainRoute(parentKey: _rootNavigatorKey).route,
        PrivacyPolicyRoute(parentKey: _rootNavigatorKey).route,
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
