import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:uniturnip/json_schema_ui.dart';

typedef CardCallback = void Function();

class IdTitleCardForm extends StatefulWidget {
  final String title;
  final String description;
  final int? id;
  final DateTime? date;
  final CardCallback onTap;
  final IconData icon;
  final Task task;

  const IdTitleCardForm({
    Key? key,
    required this.id,
    required this.title,
    required this.onTap,
    required this.icon,
    this.date,
    this.description = "",
    required this.task,
  }) : super(key: key);

  @override
  State<IdTitleCardForm> createState() => _IdTitleCardFormState();
}

class _IdTitleCardFormState extends State<IdTitleCardForm> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          leading: Icon(
            widget.icon,
            color: Theme.of(context).colorScheme.copyWith().secondary,
          ),
          title: Text(
            widget.title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Text(widget.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: widget.onTap,
                child: const Text('Open'),
              ),
              const SizedBox(width: 8),
              Icon(
                _customTileExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ],
          ),
          onExpansionChanged: (bool expanded) {
            setState(() => _customTileExpanded = expanded);
          },
          children: [
            JSONSchemaUI(
              schema: widget.task.schema!,
              ui: widget.task.uiSchema!,
              formController: UIModel(
                disabled: true,
                data: widget.task.responses ?? {},
                getFile: (path) {
                  return context.read<TasksCubit>().getFile(path);
                },
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
