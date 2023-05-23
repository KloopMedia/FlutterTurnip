import 'dart:math';

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

  List<Widget> _generateButtonList() {
    if (currentPage  < 2) {
      return List.generate(
        min(5, total),
        (index) {
          final page = index;
          return _PaginationButton(
            page: page,
            isActive: page == currentPage,
            onTap: handlePage(page),
          );
        },
      )..addAll([
          if (total > 5) const _PaginationRestPlaceholder(),
          _PaginationButton(
            page: total,
            isActive: false,
            onTap: handlePage(total),
          ),
        ]);
    } else if (currentPage > total - 2) {
      final List<Widget> buttonList = List.generate(
        min(5, total),
        (index) {
          final page = total - index;
          return _PaginationButton(
            page: page,
            isActive: page == currentPage,
            onTap: handlePage(page),
          );
        },
      );
      final reversedButtonList = buttonList.reversed.toList();
      reversedButtonList.insertAll(0, [
        _PaginationButton(
          page: 0,
          isActive: false,
          onTap: handlePage(0),
        ),
        if (total > 5) const _PaginationRestPlaceholder(),
      ]);
      return reversedButtonList;
    } else {
      return [
        _PaginationButton(
          page: 0,
          isActive: false,
          onTap: handlePage(0),
        ),
        if (total > 4) const _PaginationRestPlaceholder(),
        _PaginationButton(
          page: currentPage - 1,
          isActive: false,
          onTap: handlePage(currentPage - 1),
        ),
        _PaginationButton(
          page: currentPage,
          isActive: true,
          onTap: handlePage(currentPage),
        ),
        _PaginationButton(
          page: currentPage + 1,
          isActive: false,
          onTap: handlePage(currentPage + 1),
        ),
        if (total > 4) const _PaginationRestPlaceholder(),
        _PaginationButton(
          page: total,
          isActive: false,
          onTap: handlePage(total),
        ),
      ];
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
        _PaginationNavigationButton(
          onPressed: handlePrevPage(),
          isActive: currentPage != 0,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        ..._generateButtonList(),
        _PaginationNavigationButton(
          onPressed: handleNextPage(),
          isActive: currentPage != total,
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}

class _PaginationRestPlaceholder extends StatelessWidget {
  const _PaginationRestPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '...',
      style: TextStyle(
        color: Color(0xFF5D5E67),
      ),
    );
  }
}

class _PaginationNavigationButton extends StatelessWidget {
  final Icon icon;
  final bool isActive;
  final void Function()? onPressed;

  const _PaginationNavigationButton({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  final _shadows = const [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
      color: Color(0x1A454545),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      color: Color(0x1A454545),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.onSecondary : const Color(0x4DC2C0C0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive ? _shadows : null,
      ),
      child: IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: onPressed,
        icon: icon,
        color: isActive ? Theme.of(context).colorScheme.primary : const Color(0xffC4C7C7),
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final int page;
  final bool isActive;
  final void Function()? onTap;

  const _PaginationButton({
    Key? key,
    required this.page,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      onPressed: onTap,
      icon: Text(
        '${page + 1}',
        style: TextStyle(
          fontSize: 16,
          color: isActive ? Theme.of(context).colorScheme.primary : const Color(0xFF5D5E67),
        ),
      ),
    );
  }
}
