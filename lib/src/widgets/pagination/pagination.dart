import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final int total;
  final void Function(int page) onPageChange;

  const Pagination({Key? key, required this.total, required this.onPageChange}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 0;

  var color = Colors.grey;

  // List<Widget> createPageButtons() {
  //   final length = widget.total > 5 ? 5 : widget.total;
  //   List<Widget> buttons = [
  //     IconButton(
  //         onPressed: () {
  //           widget.onPageChange(0);
  //         },
  //         icon: const Icon(Icons.skip_previous)),
  //     IconButton(
  //         onPressed: () {
  //           if (currentPage > 1) {
  //             widget.onPageChange(currentPage - 1);
  //           } else {
  //             widget.onPageChange(0);
  //           }
  //         },
  //         icon: const Icon(Icons.keyboard_arrow_left)),
  //     IconButton(
  //         onPressed: () {
  //           if (currentPage < widget.total - 1) {
  //             widget.onPageChange(currentPage - 1);
  //           } else {
  //             widget.onPageChange(widget.total);
  //           }
  //         },
  //         icon: const Icon(Icons.keyboard_arrow_right)),
  //     IconButton(
  //         onPressed: () {
  //           widget.onPageChange(widget.total);
  //         },
  //         icon: const Icon(Icons.skip_next)),
  //   ];
  //   List<Widget> numberButtons;
  //   if (currentPage < length) {
  //     numberButtons = List.generate(length, (index) {
  //       final pageNumber = index;
  //       return Container(
  //         margin: const EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: pageNumber == currentPage ? color : null,
  //         ),
  //         child: IconButton(
  //             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
  //             onPressed: () {
  //               widget.onPageChange(pageNumber);
  //             },
  //             icon: Text((pageNumber + 1).toString())),
  //       );
  //     });
  //   } else if (currentPage > widget.total - length) {
  //     numberButtons = List.generate(length, (index) {
  //       final pageNumber = (currentPage + index);
  //       return IconButton(
  //           style: IconButton.styleFrom(backgroundColor: color),
  //           onPressed: () {
  //             widget.onPageChange(pageNumber);
  //           },
  //           icon: Text((pageNumber + 1).toString()));
  //     });
  //   } else {
  //     numberButtons = List.generate(3, (index) {
  //       final pageNumber = currentPage - 1 + index;
  //       return IconButton(
  //           color: color,
  //           onPressed: () {
  //             widget.onPageChange(pageNumber);
  //           },
  //           icon: Text((pageNumber + 1).toString()));
  //     });
  //     numberButtons.insert(0, const IconButton(onPressed: null, icon: Text('...')));
  //     numberButtons.add(const IconButton(onPressed: null, icon: Text('...')));
  //   }
  //   buttons.insertAll(2, numberButtons);
  //   return buttons;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.total == 0) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: currentPage > 0
                  ? () {
                      setState(() {
                        currentPage = 0;
                      });
                      widget.onPageChange(0);
                    }
                  : null,
              icon: const Icon(Icons.skip_previous)),
          IconButton(
              onPressed: currentPage > 0
                  ? () {
                      if (currentPage > 0) {
                        setState(() {
                          currentPage -= 1;
                        });
                        widget.onPageChange(currentPage - 1);
                      } else {
                        setState(() {
                          currentPage = 0;
                        });
                        widget.onPageChange(0);
                      }
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_left)),
          Text('${currentPage + 1}/${widget.total + 1}'),
          IconButton(
              onPressed: currentPage < widget.total
                  ? () {
                      if (currentPage < widget.total - 1) {
                        setState(() {
                          currentPage += 1;
                        });
                        widget.onPageChange(currentPage - 1);
                      } else {
                        setState(() {
                          currentPage = widget.total;
                        });
                        widget.onPageChange(widget.total);
                      }
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_right)),
          IconButton(
              onPressed: currentPage < widget.total
                  ? () {
                      setState(() {
                        currentPage = widget.total;
                      });
                      widget.onPageChange(widget.total);
                    }
                  : null,
              icon: const Icon(Icons.skip_next)),
        ],
      ),
    );
  }
}
