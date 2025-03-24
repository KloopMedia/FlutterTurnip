import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/dialogs/index.dart';
import '../../../widgets/webview/webview.dart';
import '../../../widgets/webview/webview_for_games.dart';
import '../bloc/bloc.dart';

BoxDecoration? getTaskContainerDecoration(BuildContext context) {
  if (context.isSmall || context.isMedium) return null;
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    boxShadow: Shadows.elevation3,
    color: Theme.of(context).colorScheme.onSecondary,
  );
}

EdgeInsets getTaskContainerMargin(BuildContext context) {
  if (context.isSmall || context.isMedium) return EdgeInsets.zero;
  return EdgeInsets.symmetric(
    vertical: 40,
    horizontal: MediaQuery.of(context).size.width / 5,
  );
}

void navigateToTask(BuildContext context, int? taskId, int? campaignId) {
  if (taskId != null) {
    context.goNamed(
      TaskDetailRoute.name,
      pathParameters: {
        'tid': '$taskId',
        'cid': '$campaignId',
      },
    );
  } else {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(
        TaskRoute.name,
        pathParameters: {
          'cid': '$campaignId',
        },
      );
    }
  }
}

void showTaskDialog(BuildContext context, Widget dialog) {
  showDialog(context: context, builder: (_) => dialog);
}

void openWebView(BuildContext context, String? url, String? richText, bool allowGoBack) {
  final bloc = context.read<TaskBloc>();
  final builder = url != null
      ? (context) => WebViewForGames(
            url: url,
            onCloseCallback: () => bloc.add(CloseTask()),
          )
      : (context) => WebView(
            html: richText,
            allowOpenPrevious: allowGoBack,
            onOpenPreviousTask: () => bloc.add(GoBackToPreviousTask()),
            onCloseCallback: () => bloc.add(CloseTask()),
            onSubmitCallback: () => bloc.add(CloseTaskInfo()),
          );

  Navigator.of(context).push(MaterialPageRoute(builder: builder));
}

void handleSmsRedirect(BuildContext context, String? phoneNumber, TaskDetail data) async {
  final message = jsonEncode({'stage': data.stage, 'responses': data.responses});
  final uri = Uri.parse('sms:$phoneNumber?body=$message');

  try {
    await launchUrl(uri);
  } catch (_) {
    showTaskDialog(
      context,
      OfflinePhoneMessageDialog(phoneNumber: phoneNumber ?? '', message: message),
    );
  }
}


void showNotificationDialog(BuildContext context, {required String text, required VoidCallback onPressed}) {
  showTaskDialog(
    context,
    FormDialog(
      title: context.loc.new_notification,
      content: text,
      buttonText: context.loc.got_it,
      onPressed: onPressed,
    ),
  );
}

void showTaskReturnedDialog(BuildContext context, int id) {
  showTaskDialog(
    context,
    TaskReturnedDialog(
      onPop: () => navigateToTask(context, null, id),
    ),
  );
}

void showFileDownloadedDialog(BuildContext context, String message) {
  showTaskDialog(
    context,
    FormDialog(
      content: message,
      buttonText: context.loc.ok,
    ),
  );
}

void showErrorDialog(BuildContext context, String error) {
  showTaskDialog(
    context,
    FormDialog(
      title: context.loc.form_error,
      content: error,
      buttonText: context.loc.ok,
    ),
  );
}