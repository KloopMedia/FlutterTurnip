import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;

import '../../../../widgets/widgets.dart';

String getStatusText(String? volumeText, String defaultText) {
  return (volumeText != null && volumeText.isNotEmpty) ? volumeText : defaultText;
}

Future<void> closeNotificationCardMethod(BuildContext context, int notificationId) async {
  final repo = NotificationDetailRepository(gigaTurnipApiClient: context.read<GigaTurnipApiClient>());
  await repo.markNotificationAsViewed(notificationId);
}

void showTaskCreateErrorDialog(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (context) => FormDialog(
      title: 'Error', // You might access context.loc here for localization
      content: error,
      buttonText: 'OK',
    ),
  );
}