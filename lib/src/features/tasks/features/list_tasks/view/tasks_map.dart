// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class TasksMap extends StatefulWidget {
//   final List<dynamic> allTasks;
//
//   const TasksMap({
//     Key? key,
//     required this.allTasks,
//   }) : super(key: key);
//
//   @override
//   State<TasksMap> createState() => _TasksMapState();
// }
//
// class _TasksMapState extends State<TasksMap> {
//   late int id;
//   final Map<int, dynamic> completeStatus = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//           future: context.read<TasksCubit>().getGraph(id),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               final data = snapshot.data as List<Map<String, dynamic>>;
//
//               print(data.length);
//
//               for (int i = 0; i < data.length; i++) {
//                 // Adding edges of incoming nodes
//                 final List<int?> inStage = data[i]["in_stages"].cast<int?>();
//
//                 // data[i].forEach((i,j){
//                 //   print(i);
//                 //   print(j);
//                 // });
//
//                 debugPrint(data.toString());
//
//                 for (int j = 0; j < inStage.length; j++) {
//                   if (inStage[j] != null) {
//                     graph.addEdge(
//                         Node.Id(inStage[j]), Node.Id(data[i]["pk"]));
//                   }
//                   // print("////");
//                   // print(data[i]["pk"]);
//                 }
//
//                 // Adding edges of out coming nodes
//                 final List<int?> outStage =
//                     data[i]["out_stages"].cast<int?>();
//                 for (int j = 0; j < outStage.length; j++) {
//                   if (outStage[j] != null) {
//                     graph.addEdge(
//                         Node.Id(data[i]["pk"]), Node.Id(outStage[j]));
//                   }
//                 }
//               }
//
//               return data.length > 1 ? InteractiveViewer(
//                 constrained: false,
//                 boundaryMargin: const EdgeInsets.all(100),
//                 minScale: 0.01,
//                 maxScale: 5.6,
//                 child: GraphView(
//                     graph: graph,
//                     algorithm: BuchheimWalkerAlgorithm(
//                         builder, TreeEdgeRenderer(builder)),
//                     paint: Paint()
//                       ..color = Colors.green
//                       ..strokeWidth = 1
//                       ..style = PaintingStyle.stroke,
//                     builder: (Node node) {
//                       var id = node.key!.value as int;
//                       return rectangleWidget(id, data);
//                     },
//                   ),
//               ) : const Center(child: Text("There is nothing!"),);
//
//             } else if (snapshot.hasError) {
//               return Text(snapshot.error.toString());
//             } else {
//               return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//             }
//           },
//         ),
//     );
//   }
//
//   Widget rectangleWidget(int id, List<Map<String, dynamic>> data) {
//     late Color? colorOfRectangle = Colors.grey;
//     String name = "";
//
//     if (completeStatus[id] != null) {
//       if (completeStatus[id][0]) {
//         colorOfRectangle = Colors.amber;
//       } else if (completeStatus[id][1]) {
//         colorOfRectangle = Colors.blue;
//       } else {
//         colorOfRectangle = Colors.lightGreenAccent;
//       }
//     }
//
//     // print(completeStatus);
//
//     for (int i = 0; i < data.length; i++) {
//       if (data[i]["pk"] == id) {
//         name = data[i]["name"] as String;
//         break;
//       }
//     }
//
//     return InkWell(
//       onTap: () {
//         print('clicked');
//       },
//       child: SizedBox(
//         width: 200,
//         child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(color: Colors.blue[100] as Color, spreadRadius: 1),
//                 ],
//                 color: colorOfRectangle),
//             child: Text(
//               name,
//               style: const TextStyle(fontSize: 20, color: Colors.black87),
//               textAlign: TextAlign.center,
//             )),
//       ),
//     );
//   }
//
//   final Graph graph = Graph()..isTree = true;
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
//
//   @override
//   void initState() {
//     context.read<TasksCubit>().initialize();
//
//     final list = widget.allTasks;
//
//     id = widget.allTasks[0].stage.chain.id;
//
//     // print("Id --> $id");
//     // print(widget.allTasks);
//
//
//
//     for (int i = 0; i < list.length; i++) {
//       int id = list[i].stage.id;
//       bool forceComplete = list[i].forceComplete;
//       bool complete = list[i].complete;
//
//       completeStatus.addAll({
//         id: [forceComplete, complete]
//       });
//     }
//
//     builder
//       ..siblingSeparation = (20)
//       ..levelSeparation = (20)
//       ..subtreeSeparation = (20)
//       ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
//
//     super.initState();
//   }
// }
