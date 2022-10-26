import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/index.dart';

const kTileHeight = 100.0;

class TimeLine extends StatefulWidget {
  const TimeLine({
    Key? key,
    required this.allTasks,
  }) : super(key: key);

  final List<dynamic> allTasks;

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  late int id;

  List<dynamic> addNext(int lastElement, Map<int, dynamic> nextId){
    List<dynamic> timelineList = [];
    dynamic last = lastElement as List<dynamic>;

    timelineList.add(last);

    if(last == null){
      return timelineList;
    } else if (last.length > 1){
      last.forEach((e) => {timelineList.add(nextId[e])});
      addNext(timelineList.last, nextId);
      last = timelineList.last;
    } else {
      timelineList.add(nextId[last]);
      addNext(timelineList.last, nextId);
      last = timelineList.last;
    }

    return timelineList;
  }

  @override
  void initState() {
    context.read<TasksCubit>().initialize();

    id = widget.allTasks[0].stage.chain.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: context.read<TasksCubit>().getGraph(id),
          builder: (context, snapshot) {
            late List<dynamic> timelineList = [];
            final Map<int, dynamic> nextId = {};


            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data as List<Map<String, dynamic>>;

              // Adding first element --> Head of the map
              int firstElement = 0;
              for (int i = 0; i < data.length; i++) {
                if (data[i]["in_stages"][0] == null) {
                  // timelineList.add(data[i]["pk"]);
                  firstElement = data[i]["pk"];
                }
              }

              for(int i = 0; i < data.length; i++){
                // print(data[i]["pk"]);
                nextId.addAll({
                  data[i]["pk"] : data[i]["out_stages"]
                });
              }

              print(nextId);

              // int lastElement = timelineList.last;

              // while(lastElement != null){
              //   timelineList.addAll(nextId[lastElement]);
              // }

              // void addNext(int id){
              //   for(int j = 0; j < data.length; j++){
              //     if(timelineList[k - 1] == data[j]["pk"]){
              //       if(data[j]["out_stages"] == null){
              //         break;
              //       } else {
              //         timelineList.add(data[j]["out_stages"]);
              //         addNext(k+1);
              //       }
              //     }
              //   }
              // }

              // addNext(timelineList[k]);



              // var key = data.keys.firstWhere((k) => map[k] == 'Bag', orElse: () => null);

              // for(int i = 0; i < data.length; i++){
              //   if(data[i]["pk"] == timelineList.last){
              //     timelineList.add(data[i]["out_stages"]);
              //   }
              // }

              timelineList = addNext(firstElement, nextId);

              print(data);
              print(timelineList);
            }


            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _TimeLineStatus(timelineList),
              ),
            );
          }),
    );
  }
}

class _TimeLineStatus extends StatelessWidget {
  final List<dynamic> data;


  const _TimeLineStatus(this.data);

  @override
  Widget build(BuildContext context) {
    // final data = _TimelineStatus.values;
    final data = [
      _TimelineStatus.done,
      _TimelineStatus.done,
      _TimelineStatus.todo,
      _TimelineStatus.sync,
      _TimelineStatus.inProgress,
      _TimelineStatus.done,
      _TimelineStatus.done,
      _TimelineStatus.todo,
      _TimelineStatus.sync,
      _TimelineStatus.inProgress,
      _TimelineStatus.done,
      _TimelineStatus.done,
      _TimelineStatus.todo,
      _TimelineStatus.sync,
      _TimelineStatus.inProgress,
      _TimelineStatus.done,
      _TimelineStatus.done,
      _TimelineStatus.todo,
      _TimelineStatus.sync,
      _TimelineStatus.inProgress,
    ];
    return Timeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: const ConnectorThemeData(
            thickness: 3.0,
            color: Color(0xffd3d3d3),
          ),
          indicatorTheme: const IndicatorThemeData(
            size: 15.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, __) => _Description(),
          connectorBuilder: (_, index, __) {
            if (index == 0) {
              return const SolidLineConnector(
                color: Color(0xff6ad192),
              );
            } else {
              return const SolidLineConnector();
            }
          },
          indicatorBuilder: (_, index) {
            switch (data[index]) {
              case _TimelineStatus.done:
                return const DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10.0,
                  ),
                );
              case _TimelineStatus.sync:
                return const DotIndicator(
                  color: Color(0xff193fcc),
                  child: Icon(
                    Icons.sync,
                    size: 10.0,
                    color: Colors.white,
                  ),
                );
              case _TimelineStatus.inProgress:
                return const OutlinedDotIndicator(
                  color: Color(0xffa7842a),
                  borderWidth: 2.0,
                  backgroundColor: Color(0xffebcb62),
                );
              case _TimelineStatus.todo:
              default:
                return const OutlinedDotIndicator(
                  color: Color(0xffbabdc0),
                  backgroundColor: Color(0xffe6e7e9),
                );
            }
          },
          itemExtentBuilder: (_, __) => kTileHeight,
          itemCount: data.length,
        ),
      );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      height: 80.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xffe6e7e9),
      ),
      child: Column(
        children: [
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(5),
              child: Center(child: Text('HI there who are you doing')),
            ),
            SizedBox(),
            IconButton(
              onPressed: () {
                print("clicked");
              },
              icon: const Icon(Icons.edit),
            ),
          ],),
          // const Center(
          //     child: Text("Hello there, here we will have very long text")),
        ],
      ),
    );
  }
}

enum _TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}
