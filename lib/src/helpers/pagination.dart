import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int total;
  final bool enabled;
  final void Function(int page) onChanged;

  const Pagination({
    Key? key,
    required this.currentPage,
    required this.total,
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  get hasNext => currentPage < total;

  get hasPrev => currentPage > 0;

  void Function()? handlePage(int page) {
    return enabled ? () => onChanged(page) : null;
  }

  void Function()? handleFirstPage() {
    if (hasPrev) {
      return handlePage(0);
    } else {
      return null;
    }
  }

  Function()? handlePrevPage() {
    if (hasPrev) {
      return handlePage(currentPage - 1);
    } else {
      return null;
    }
  }

  void Function()? handleNextPage() {
    if (hasNext) {
      return handlePage(currentPage + 1);
    } else {
      return null;
    }
  }

  void Function()? handleLastPage() {
    if (hasNext) {
      return handlePage(total);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (total == 0) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: handleFirstPage(), icon: const Icon(Icons.skip_previous)),
        IconButton(onPressed: handlePrevPage(), icon: const Icon(Icons.keyboard_arrow_left)),
        Text('${currentPage + 1}/${total + 1}'),
        IconButton(onPressed: handleNextPage(), icon: const Icon(Icons.keyboard_arrow_right)),
        IconButton(onPressed: handleLastPage(), icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
