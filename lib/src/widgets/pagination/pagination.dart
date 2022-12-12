import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final int total;
  final void Function(int page) onPageChange;

  const Pagination({Key? key, required this.total, required this.onPageChange})
      : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 0;

  var color = Colors.grey;

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
