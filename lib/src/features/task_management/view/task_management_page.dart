import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:graphview/GraphView.dart';

class TaskManagementPage extends StatefulWidget {
  final int campaignId;
  final int chainId;

  const TaskManagementPage({super.key, required this.campaignId, required this.chainId});

  @override
  State<TaskManagementPage> createState() => _TaskManagementPageState();
}

class TaskNode extends Node {
  final String? title;
  final BaseStageType? type;
  final List<Map<String, dynamic>>? conditions;
  final List<String>? ranks;

  TaskNode(
    dynamic id, {
    this.title,
    this.type,
    this.conditions,
    this.ranks,
  }) : super.Id(id);
}

class _TaskManagementPageState extends State<TaskManagementPage> {
  late Future<Map<int, BaseStage>> futureStages;

  @override
  initState() {
    futureStages = fetchStages();
    super.initState();
  }

  Future<Map<int, BaseStage>> fetchStages() async {
    final client = context.read<GigaTurnipApiClient>();

    final requestQueryParameters = {
      'limit': 100,
      'chain': widget.chainId,
      'chain__campaign': widget.campaignId,
    };

    final taskStages = await client.getTaskStages(query: requestQueryParameters);
    final conditionalStages = await client.getConditionalStages(query: requestQueryParameters);

    Map<int, BaseStage> parsed = {};
    for (var element in [...taskStages.results, ...conditionalStages.results]) {
      parsed[element.id] = element;
    }
    return parsed;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: const Text('Task management'),
      child: FutureBuilder(
          future: futureStages,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var stage in snapshot.data!.entries) {
                for (var outStageId in stage.value.outStages) {
                  final inStage = stage.value;
                  final outStage = snapshot.data![outStageId];

                  final inNode = TaskNode(
                    inStage.id,
                    title: inStage.name,
                    type: inStage.type,
                  );
                  final outNode = TaskNode(
                    outStage?.id ?? outStageId,
                    title: outStage?.name,
                    type: outStage?.type,
                  );

                  graph.addEdge(inNode, outNode);
                }
              }

              return InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.001,
                maxScale: 5.6,
                child: GraphView(
                  graph: graph,
                  algorithm: SugiyamaAlgorithm(
                    SugiyamaConfiguration()
                      ..levelSeparation = 20
                      ..nodeSeparation = 20,
                  ),
                  paint: Paint()
                    ..color = Colors.grey
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    return taskNodeWidget(node as TaskNode);
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget taskNodeWidget(TaskNode node) {
    return InkWell(
      onTap: () {
        print('clicked ${node.key?.value.toString()}');
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.green[100]!,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Builder(
              builder: (context) {
                if (node.title != null) {
                  return Text(node.title!);
                }
                return Text(node.key!.value.toString());
              },
            ),
          ),
          for (var rank in node.ranks ?? [])
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow[100]!,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(rank),
            )
        ],
      ),
    );
  }

  Widget rectangleWidget(TaskNode node) {
    return InkWell(
      onTap: () {
        print('clicked ${node.key?.value.toString()}');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: switch (node.type) {
                BaseStageType.task => Colors.green[100]!,
                BaseStageType.conditional => Colors.blue[100]!,
                _ => Colors.green[100]!,
              },
              spreadRadius: 1,
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            if (node.title != null) {
              return Text(node.title!);
            }
            return Text(node.key!.value.toString());
          },
        ),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  final builder = FruchtermanReingoldAlgorithm();
}
