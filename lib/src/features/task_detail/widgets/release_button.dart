import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/dialogs/index.dart';
import '../bloc/bloc.dart';
import '../util/util.dart';

/// A button to release the current task if allowed.
class ReleaseButton extends StatelessWidget {
  final TaskBloc bloc;
  final TaskDetail task;
  final int campaignId;

  const ReleaseButton({
    super.key,
    required this.bloc,
    required this.task,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    if (!task.stage.allowRelease) {
      return const SizedBox.shrink();
    }
    return TextButton(
      onPressed: () => _showReleaseDialog(context),
      child: Text(context.loc.release_task_button),
    );
  }

  void _showReleaseDialog(BuildContext context) {
    showTaskDialog(
      context,
      ReleaseTaskDialog(
        onConfirm: () => bloc.add(ReleaseTask()),
      ),
    );
  }
}