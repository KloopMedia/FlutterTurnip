import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

typedef CardCallback = void Function();

class FormCard extends StatelessWidget {
  final String title;
  final String description;
  final int id;
  final DateTime? date;
  final CardCallback onTap;
  final bool status;
  final Task task;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const FormCard({
    Key? key,
    required this.id,
    required this.title,
    required this.onTap,
    required this.status,
    required this.task,
    this.date,
    this.description = "",
    this.margin,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          CardHeader(title: title, id: id, status: status),
          CardBody(task: task),
          const SizedBox(height: 8),
          CardFooter(status: status, onTap: onTap),
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final int id;
  final bool status;

  const CardHeader({Key? key, required this.title, required this.id, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(title),
              subtitle: Text('#$id'),
            ),
          ),
          StatusBar(status: status),
        ],
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  final Task task;

  const CardBody({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasCardData = task.cardJsonSchema != null && task.cardJsonSchema!.isNotEmpty;
    return JSONSchemaUI(
      schema: hasCardData ? task.cardJsonSchema! : task.schema!,
      ui: hasCardData ? task.cardUiSchema! : task.uiSchema!,
      formController: UIModel(disabled: true),
    );
  }
}

class CardFooter extends StatelessWidget {
  final bool status;
  final CardCallback onTap;

  const CardFooter({Key? key, required this.onTap, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: status
              ? const Text(
                  'Ваше обращение получено!',
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                )
              : const SizedBox.shrink(),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              context.loc.edit,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class StatusBar extends StatelessWidget {
  final bool status;

  const StatusBar({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          status ? Icons.done_all_outlined : Icons.warning_amber_outlined,
          color: status ? Colors.green : Colors.red,
        ),
        Text(
          status ? context.loc.sent : context.loc.notsent,
          style: TextStyle(color: status ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}
