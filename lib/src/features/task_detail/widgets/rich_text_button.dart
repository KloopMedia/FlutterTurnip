import 'package:flutter/material.dart';

import '../../../widgets/button/dialog/dialog_button_outlined.dart';
import '../bloc/bloc.dart';

/// A button that, when pressed, triggers an event to open task info (rich text).
class RichTextButton extends StatelessWidget {
  final TaskBloc bloc;

  const RichTextButton({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: DialogButtonOutlined(
        child: const Text('Open Rich Text'),
        onPressed: () => bloc.add(OpenTaskInfo()),
      ),
    );
  }
}