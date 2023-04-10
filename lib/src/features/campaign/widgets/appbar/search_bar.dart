import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
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
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          _SearchIcon(),
          _SearchField(),
          _SearchDivider(),
          _SearchFilter(),
        ],
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13.sp, 0.sp, 12.sp, 0.sp),
      child: Icon(
        Icons.search,
        size: 24.h,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    return Expanded(
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration.collapsed(
          hintText: 'Что вы ищите?',
          hintStyle: textStyle,
        ),
        style: textStyle,
      ),
    );
  }
}

class _SearchDivider extends StatelessWidget {
  const _SearchDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: const VerticalDivider(
        thickness: 1,
      ),
    );
  }
}

class _SearchFilter extends StatelessWidget {
  const _SearchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        Icons.filter_1,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: () {
        print('Button pressed ...');
      },
      label: Text(
        'Фильтр',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
