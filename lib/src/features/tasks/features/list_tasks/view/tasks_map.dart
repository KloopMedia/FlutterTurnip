import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';

import '../cubit/index.dart';

// typedef ItemCallback = void Function(dynamic item);
// typedef RefreshCallback = void Function();

class TasksMap extends StatefulWidget {
  final List<dynamic> allTasks;

  TasksMap({
    Key? key,
    required this.allTasks,
  }) : super(key : key);

  @override
  State<TasksMap> createState() => _TasksMapState();
}

class _TasksMapState extends State<TasksMap> {


  @override
  Widget build(BuildContext context){
    return Scaffold(body: InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          var a = node.key!.value as int;
          return rectangleWidget(a);
        },
      ),
    )
    );
  }

  Widget rectangleWidget(int a) {
    String name = "";
    for (int i = 0; i < data.length; i++) {
      if (data[i]["pk"] == a) {
        name = data[i]["name"] as String;
        break;
      }
    }
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: SizedBox(
        width: 200,
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.blue[100] as Color, spreadRadius: 1),
                ],
                color: Colors.amber),
            child: Text(name, style: const TextStyle(fontSize: 20, color: Colors.black87), textAlign: TextAlign.center,)),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {

    final data = context.read<TasksCubit>().getGraph();

    print(widget.allTasks[0].outStages);
    print("-----------------------------");
    print(widget.allTasks[0].stage.inStages);
    super.initState();

    // final data = widget.allTasks[0];
    // final nodes = [];
    for (int i = 0; i < data.length; i++){
      // nodes.add(Node.Id(data[i]["pk"]));

      List<int?> inStage = data[i]["in_stages"] as List<int?>;

      for (int j = 0; j < inStage.length; j++) {
        if (inStage[j] != null) {
          graph.addEdge(Node.Id(inStage[j]), Node.Id(data[i]["pk"]));
        }
      }

      List<int?> outStage = data[i]["out_stages"] as List<int?>;
      for (int j = 0; j < outStage.length; j++) {
        if (outStage[j] != null) {
          graph.addEdge(Node.Id(data[i]["pk"]), Node.Id(outStage[j]));
        }
      }
    }

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (30)
      ..subtreeSeparation = (70)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

}



final data = [
  {
    "pk": 1707,
    "name": "Онлайн жолугушууга жазылуу / Записаться на онлайн прием",
    "in_stages": [1927],
    "out_stages": [1711]
  },
  {
    "pk": 1708,
    "name":
    "Онлайн жолугушууга катталууңуз ырасталды / Запись на онлайн прием подтверждена",
    "in_stages": [1710],
    "out_stages": [1821]
  },
  {
    "pk": 1710,
    "name":
    "Онлайн кабыл алуу жазуусун ырастоо / Подтверждение записи на онлайн прием",
    "in_stages": [1711],
    "out_stages": [1708, 1735, 1736]
  },
  {
    "pk": 1711,
    "name": "возврат записи на онлайн конференцию",
    "in_stages": [1707],
    "out_stages": [1710]
  },
  {
    "pk": 1726,
    "name": "Онлайн жолугушууну баалоо формасы / Форма оценки онлайн приема",
    "in_stages": [1737],
    "out_stages": [null]
  },
  {
    "pk": 1735,
    "name": "Аткаруучунун формасы (онлайн) / Форма исполнителя (онлайн)",
    "in_stages": [1710],
    "out_stages": [1737]
  },
  {
    "pk": 1736,
    "name": "Жалпы бөлүм үчүн форма (онлайн) / Форма в общий отдел (онлайн)",
    "in_stages": [1710],
    "out_stages": [null]
  },
  {
    "pk": 1737,
    "name":
    "Аткаруучунун кайтарым байланыш формасы (онлайн) / Форма обратной связи исполнителя (онлайн)",
    "in_stages": [1735],
    "out_stages": [1726]
  },
  {
    "pk": 1821,
    "name":
    "Онлайн жолугушуунун ой-пикир формасы / Форма отзыва на онлайн прием",
    "in_stages": [1708],
    "out_stages": [null]
  },
  {
    "pk": 1925,
    "name": "Жолугушууга жазылуу / Записаться на прием",
    "in_stages": [null],
    "out_stages": [1927, 1928, 1961]
  },
  {
    "pk": 1926,
    "name": "Офлайн жолугушууга жазылуу / Записаться на офлайн прием",
    "in_stages": [1928],
    "out_stages": [1931]
  },
  {
    "pk": 1927,
    "name": "если онлайн",
    "in_stages": [1925],
    "out_stages": [1707]
  },
  {
    "pk": 1928,
    "name": "если оффлайн",
    "in_stages": [1925],
    "out_stages": [1926]
  },
  {
    "pk": 1930,
    "name":
    "Офлайн кабыл алуу жазуусун ырастоо / Подтверждение записи на офлайн прием",
    "in_stages": [1931],
    "out_stages": [1932, 1935, 1968, 1972]
  },
  {
    "pk": 1931,
    "name": "возврат записи на офлайн прием",
    "in_stages": [1926],
    "out_stages": [1930]
  },
  {
    "pk": 1932,
    "name": "Background подтверждения офлайн приема",
    "in_stages": [1930],
    "out_stages": [null]
  },
  {
    "pk": 1935,
    "name":
    "Офлайн жолугушууга катталууңуз ырасталды / Запись на офлайн прием подтверждена",
    "in_stages": [1930],
    "out_stages": [1971]
  },
  {
    "pk": 1960,
    "name":
    "Жарандардын аппараттын ишине даттануулары / Жалобы граждан на работу аппарата",
    "in_stages": [1973],
    "out_stages": [null]
  },
  {
    "pk": 1961,
    "name": "если жалоба",
    "in_stages": [1925],
    "out_stages": [1973]
  },
  {
    "pk": 1968,
    "name": "Аткаруучунун формасы (офлайн) / Форма испонителя (офлайн)",
    "in_stages": [1930],
    "out_stages": [1969]
  },
  {
    "pk": 1969,
    "name":
    "Аткаруучунун кайтарым байланыш формасы (офлайн) / Форма обратной связи исполнителя (офлайн)",
    "in_stages": [1968],
    "out_stages": [1970]
  },
  {
    "pk": 1970,
    "name": "Офлайн жолугушууну баалоо формасы / Форма оценки офлайн приема",
    "in_stages": [1969],
    "out_stages": [null]
  },
  {
    "pk": 1971,
    "name":
    "Офлайн жолугушуунун ой-пикир формасы / Форма отзыва на офлайн прием",
    "in_stages": [1935],
    "out_stages": [null]
  },
  {
    "pk": 1972,
    "name": "Жалпы бөлүм үчүн форма (офлайн) / Форма в общий отдел (офлайн)",
    "in_stages": [1930],
    "out_stages": [null]
  },
  {
    "pk": 1973,
    "name": "autocomplete приемная",
    "in_stages": [1961],
    "out_stages": [1960]
  }
];

class TreeViewPage extends StatefulWidget {
  const TreeViewPage({super.key});

  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      var a = node.key!.value as int;
                      return rectangleWidget(a);
                    },
                  ),
                  );
  }


  Widget rectangleWidget(int a) {
    String name = "";
    for (int i = 0; i < data.length; i++) {
      if (data[i]["pk"] == a) {
        name = data[i]["name"] as String;
        break;
      }
    }
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: SizedBox(
        width: 200,
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.blue[100] as Color, spreadRadius: 1),
                ],
                color: Colors.amber),
            child: Text(name, style: const TextStyle(fontSize: 20, color: Colors.black87), textAlign: TextAlign.center,)),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();

    // final nodes = [];
    for (int i = 0; i < data.length; i++) {
      // nodes.add(Node.Id(data[i]["pk"]));

      List<int?> inStage = data[i]["in_stages"] as List<int?>;

      for (int j = 0; j < inStage.length; j++) {
        if (inStage[j] != null) {
          graph.addEdge(Node.Id(inStage[j]), Node.Id(data[i]["pk"]));
        }
      }

      List<int?> outStage = data[i]["out_stages"] as List<int?>;
      for (int j = 0; j < outStage.length; j++) {
        if (outStage[j] != null) {
          graph.addEdge(Node.Id(data[i]["pk"]), Node.Id(outStage[j]));
        }
      }
    }

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (30)
      ..subtreeSeparation = (70)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}